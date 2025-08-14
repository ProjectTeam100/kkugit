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
import 'package:kkugit/util/parser/card_parser.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();
  bool? _isIncome = false; // 기본값: false (지출)
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

  // 결제수단 확장/선택 상태
  bool _isPaymentExpanded = false;
  final List<String> _paymentOptions = ['현금', '카드', '계좌이체', '기타'];

  // 확장 상태 변수
  bool _isDescriptionExpanded = false;
  bool _isGroupExpanded = false;
  bool _isMemoExpanded = false;

  List<Category> get _categories =>
      _isIncome == true ? _incomeCategories : _expenseCategories;

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
    final income = await _categoryService.getByType(CategoryType.income);
    final expense = await _categoryService.getByType(CategoryType.expense);
    if (!mounted) return; // 위젯이 마운트되지 않은 경우 처리
    setState(() {
      _incomeCategories = income;
      _expenseCategories = expense;
    });
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

  void _showInputDialog(
      String title, String currentValue, Function(String) onSave) {
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
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('취소')),
          TextButton(
              onPressed: () {
                onSave(controller.text);
                Navigator.pop(context);
              },
              child: const Text('저장')),
        ],
      ),
    );
  }

  void _saveData() async {
    if (_isIncome == null ||
        _amountController.text.isEmpty ||
        int.tryParse(_amountController.text) == null ||
        int.parse(_amountController.text) <= 0 ||
        _description.trim().isEmpty ||
        _category == null ||
        _category!.id == null ||
        (_isIncome == false && _paymentMethod.trim().isEmpty)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('입력값을 확인해주세요.')));
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
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('저장 실패: $error')));
      return;
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_isIncome! ? '수입' : '지출'} 내역이 저장되었습니다.')));
    Navigator.pop(context, true);
  }

  void _getClipboardData() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    if (clipboardData?.text != null && clipboardData!.text!.isNotEmpty) {
      final message = clipboardData.text!.trim();
      final parsed = await cardParseChain.handle(message);
      if (parsed != null) {
        setState(() {
          _amountController.text = parsed.amount.toString();
          _description = parsed.client;
          _paymentMethod = parsed.payment;
          _selectedDate = parsed.dateTime;
          _isIncome = parsed.type == TransactionType.income;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('클립보드 데이터를 불러왔습니다.')));
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('클립보드 데이터 형식이 올바르지 않습니다.')));
      }
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('클립보드에 데이터가 없습니다.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('내역 추가', style: TextStyle(fontWeight: FontWeight.bold)),
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
                        const Text('날짜',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Text(DateFormat('yyyy.MM.dd').format(_selectedDate)),
                      ],
                    ),
                  ),
                  DropdownButton<String>(
                    value: _repeatOrInstallment,
                    items: ['없음', '반복', '할부']
                        .map((option) => DropdownMenuItem(
                            value: option, child: Text(option)))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _repeatOrInstallment = value!),
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
                  const Text('금액',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      focusNode: _amountFocusNode,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '000원',
                        hintStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
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

            // 내역 입력 (확장형)
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => setState(
                        () => _isDescriptionExpanded = !_isDescriptionExpanded),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _description.isEmpty ? '내역' : _description,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            _isDescriptionExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isDescriptionExpanded)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextField(
                        controller: TextEditingController(text: _description),
                        onChanged: (value) =>
                            setState(() => _description = value),
                        decoration: const InputDecoration(
                          hintText: '내역 입력',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // 카테고리 선택
            _buildCategorySelector(),

            // 그룹 입력 (확장형)
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () =>
                        setState(() => _isGroupExpanded = !_isGroupExpanded),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _group?.name.isEmpty ?? true ? '그룹' : _group!.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            _isGroupExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isGroupExpanded)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextField(
                        controller:
                            TextEditingController(text: _group?.name ?? ''),
                        onChanged: (value) => setState(() => _group =
                            Group(name: value, type: GroupType.expense)),
                        decoration: const InputDecoration(
                          hintText: '그룹 입력',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            if (_isIncome == false)
              Container(
                width: double.infinity,
                color: Colors.grey[200],
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => setState(
                          () => _isPaymentExpanded = !_isPaymentExpanded),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _paymentMethod.isEmpty ? '결제수단' : _paymentMethod,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              _isPaymentExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_isPaymentExpanded)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _paymentOptions.map((option) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _paymentMethod = option;
                                  _isPaymentExpanded = false;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(option,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),

            // 메모 입력 (확장형)
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              margin: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () =>
                        setState(() => _isMemoExpanded = !_isMemoExpanded),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _memo.isEmpty ? '메모' : _memo,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            _isMemoExpanded
                                ? Icons.expand_less
                                : Icons.expand_more,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_isMemoExpanded)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextField(
                        controller: TextEditingController(text: _memo),
                        maxLines: 5,
                        onChanged: (value) => setState(() => _memo = value),
                        decoration: const InputDecoration(
                          hintText: '메모 입력',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // 클립보드 불러오기 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: _getClipboardData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('클립보드 불러오기',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
            ),

            const SizedBox(height: 20),

            // 저장 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: _saveData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('저장하기',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
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
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black : Colors.grey[700]),
        ),
      ),
    );
  }

  Widget _buildItemInput(
      String label, String value, ValueChanged<String> onChanged,
      {int maxLines = 1}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.grey[200],
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: TextEditingController(text: value),
            onChanged: onChanged,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: '$label 입력',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              isDense: true,
            ),
          ),
        ],
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
            Text(value.isEmpty ? label : value,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
            onTap: () =>
                setState(() => _isCategoryExpanded = !_isCategoryExpanded),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_category == null ? '카테고리' : _category!.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Icon(
                      _isCategoryExpanded
                          ? Icons.expand_less
                          : Icons.expand_more,
                      size: 20),
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
                  // 카테고리 목록
                  ..._categories.map((category) => GestureDetector(
                        onTap: () => setState(() {
                          _category = category;
                          _isCategoryExpanded = false;
                        }),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 4),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(category.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500)),
                        ),
                      )),
                  // 카테고리 추가 버튼
                  GestureDetector(
                    onTap: () {
                      if (_isIncome == null) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CategoryEditScreen(isIncome: _isIncome!)),
                      ).then((result) {
                        if (result == true) {
                          _fetchCategories();
                          setState(() => _isCategoryExpanded = true);
                        }
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 4),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text('편집',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500)),
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
