import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kkugit/data/model/category.dart';
import 'package:kkugit/data/model/group.dart';
import 'package:kkugit/data/model/transaction.dart';
import 'package:kkugit/data/service/category_service.dart';
import 'package:kkugit/data/service/transaction_service.dart';
import 'package:kkugit/di/injection.dart';
import 'package:kkugit/screens/category_edit_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();
  bool? _isIncome;
  DateTime _selectedDate = DateTime.now();
  final _transactionService = getIt<TransactionService>();
  final _categoryService = getIt<CategoryService>();
  String _description = '';
  Category? _category;
  Group? _group;
  String _paymentMethod = '';
  String _memo = '';
  List<Category> _incomeCategories = [];
  List<Category> _expenseCategories = [];
  bool _isCategoryExpanded = false;
  String _repeatOrInstallment = '없음';

  List<Category> get _categories => _isIncome == true ? _incomeCategories : _expenseCategories;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  void _fetchCategories() async {
    _incomeCategories = await _categoryService.getByType(CategoryType.income);
    _expenseCategories = await _categoryService.getByType(CategoryType.expense);
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _showInputDialog(String title, String currentValue, Function(String) onSave) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: '$title을(를) 입력하세요'),
          maxLines: title == '메모' ? 5 : 1,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          TextButton(onPressed: () { onSave(controller.text); Navigator.pop(context); }, child: const Text('저장')),
        ],
      ),
    );
  }

  void _saveData() async {
    if (_isIncome == null || _amountController.text.isEmpty || int.tryParse(_amountController.text) == null || int.parse(_amountController.text) <= 0 || _description.trim().isEmpty || _category == null || _category!.id == null || (_isIncome == false && _paymentMethod.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('입력값을 확인해주세요.')));
      return;
    }

    try {
      await _transactionService.add(
        _selectedDate,
        _description,
        _isIncome == false ? _paymentMethod : '',
        _category!.id!,
        _group?.id ?? 0,
        int.parse(_amountController.text),
        _memo,
        _isIncome! ? TransactionType.income : TransactionType.expense,
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('저장 실패: $error')));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${_isIncome! ? '수입' : '지출'} 내역이 저장되었습니다.')));
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내역 추가', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.grey[300],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _pickDate,
                    child: Row(
                      children: [
                        const Text('날짜', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Text(DateFormat('yyyy.MM.dd').format(_selectedDate)),
                      ],
                    ),
                  ),
                  DropdownButton<String>(
                    value: _repeatOrInstallment,
                    items: ['없음', '반복', '할부'].map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
                    onChanged: (value) => setState(() => _repeatOrInstallment = value!),
                  )
                ],
              ),
            ),

            // 금액 입력
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('금액', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      focusNode: _amountFocusNode,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '000원',
                        hintStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTypeButton('수입', true),
                  const SizedBox(width: 10),
                  _buildTypeButton('지출', false),
                ],
              ),
            ),

            _buildItemButton('내역', _description, () => _showInputDialog('내역', _description, (value) => setState(() => _description = value))),

            // 카테고리 선택
            _buildCategorySelector(),

            _buildItemButton('그룹', _group?.name ?? '선택 안함', () => _showInputDialog('그룹', _group?.name ?? '선택 안함', (value) {})),

            if (_isIncome == false)
              _buildItemButton('결제수단', _paymentMethod, () => _showInputDialog('결제수단', _paymentMethod, (value) => setState(() => _paymentMethod = value))),

            _buildItemButton('메모', _memo, () => _showInputDialog('메모', _memo, (value) => setState(() => _memo = value))),

            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: _saveData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('저장하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeButton(String text, bool isIncome) {
    final isSelected = _isIncome == isIncome;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isIncome = isIncome;
          _category = null;
          _paymentMethod = '';
        });
        _fetchCategories();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[400] : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isSelected ? Colors.black : Colors.grey[700]),
        ),
      ),
    );
  }

  Widget _buildItemButton(String label, String value, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.grey[200],
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value.isEmpty ? label : value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _isCategoryExpanded = !_isCategoryExpanded),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_category == null ? '카테고리' : _category!.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Icon(_isCategoryExpanded ? Icons.expand_less : Icons.expand_more, size: 20),
                ],
              ),
            ),
          ),
          if (_isCategoryExpanded)
            Container(
              constraints: const BoxConstraints(maxHeight: 240),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                childAspectRatio: 2.2,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  ..._categories.map((category) => GestureDetector(
                    onTap: () => setState(() {
                      _category = category;
                      _isCategoryExpanded = false;
                    }),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
                      child: Text(category.name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    ),
                  )),
                  GestureDetector(
                    onTap: () {
                      if (_isIncome == null) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CategoryEditScreen(isIncome: _isIncome!)),
                      ).then((result) {
                        if (result == true) {
                          _fetchCategories();
                          setState(() => _isCategoryExpanded = true);
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
                      child: const Text('편집', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
