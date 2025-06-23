import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kkugit/data/model/category.dart';
import 'package:hive/hive.dart';
import 'package:kkugit/screens/category_edit_screen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _amountController = TextEditingController();
  final FocusNode _amountFocusNode = FocusNode();
  bool? _isIncome; // null: not selected
  DateTime _selectedDate = DateTime.now();

  // 통합 입력 항목
  String _description = '';
  String _category = '';
  String _group = '';
  String _paymentMethod = '';
  String _memo = '';
  List<Category> _categories = [];
  bool _isCategoryExpanded = false;

  @override
  void initState() {
    super.initState();
    // 초기 카테고리 목록 불러오기
    _initializeCategories();
  }

  Future<void> _initializeCategories() async {
    // isIncome이 null이면 초기화하지 않음
    if (_isIncome == null) {
      setState(() {
        _categories = [];
      });
      return;
    }
    if (!Hive.isBoxOpen('categoryBox')) {
      await Hive.openBox<Category>('categoryBox');
    }
    final box = Hive.box<Category>('categoryBox');
    final categories =
        box.values.where((cat) => cat.isIncome == _isIncome).toList();
    setState(() {
      _categories = categories;
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  void _showInputDialog(
    String title,
    String currentValue,
    Function(String) onSave,
  ) {
    final TextEditingController controller =
        TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: '${title}을(를) 입력하세요',
          ),
          maxLines: title == '메모' ? 5 : 1,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }

  void _saveData() {
    // 유효성 검사
    if (_isIncome == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('수입 또는 지출을 선택해주세요')),
      );
      return;
    }
    if (_amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('금액을 입력해주세요')),
      );
      return;
    }
    final int amount = int.tryParse(_amountController.text) ?? 0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('0원보다 큰 금액을 입력해주세요')),
      );
      return;
    }
    if (_description.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('내역을 입력해주세요')),
      );
      return;
    }
    if (_category.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('카테고리를 선택해주세요')),
      );
      return;
    }
    // 결제수단(지출시)
    if (_isIncome == false && _paymentMethod.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('결제수단을 입력해주세요')),
      );
      return;
    }
    // 실제 저장 로직 필요
    // ...
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${_isIncome! ? '수입' : '지출'} 데이터가 저장되었습니다.')),
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Text(
                DateFormat('yyyy.MM.dd').format(_selectedDate),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // 반복/할부 버튼은 제거됨 또는 필요시 여기에 배치
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 금액 입력 카드
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.grey[200],
                child: InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(_amountFocusNode);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('금액',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
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
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) {
                            if (value.isEmpty) return;
                            final parsed = int.tryParse(value) ?? 0;
                            final formatted = parsed.toString();
                            if (formatted != value) {
                              _amountController.value = TextEditingValue(
                                text: formatted,
                                selection: TextSelection.collapsed(
                                    offset: formatted.length),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 수입/지출 선택
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

              // 내역
              _buildItemButton(
                '내역',
                _description,
                () => _showInputDialog('내역', _description, (value) {
                  setState(() {
                    _description = value;
                  });
                }),
              ),

              // 카테고리 (확장형)
              Container(
                width: double.infinity,
                color: Colors.grey[200],
                margin: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isCategoryExpanded = !_isCategoryExpanded;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _category.isEmpty ? '카테고리' : _category,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              _isCategoryExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_isCategoryExpanded)
                      Container(
                        constraints: const BoxConstraints(maxHeight: 240),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: GridView.count(
                          key: ValueKey(_categories.length),
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          childAspectRatio: 2.2,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            ..._categories.map((category) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _category = category.name;
                                    _isCategoryExpanded = false;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    category.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              );
                            }),
                            GestureDetector(
                              onTap: () {
                                if (_isIncome == null) return;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryEditScreen(
                                      isIncome: _isIncome!,
                                    ),
                                  ),
                                ).then((result) {
                                  if (result == true) {
                                    _initializeCategories();
                                    setState(() {
                                      _isCategoryExpanded = true;
                                    });
                                  }
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 4),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  '편집',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // 그룹
              _buildItemButton(
                '그룹',
                _group,
                () => _showInputDialog('그룹', _group, (value) {
                  setState(() {
                    _group = value;
                  });
                }),
              ),

              // 결제수단 (지출일 때만)
              if (_isIncome == false)
                _buildItemButton(
                  '결제수단',
                  _paymentMethod,
                  () => _showInputDialog('결제수단', _paymentMethod, (value) {
                    setState(() {
                      _paymentMethod = value;
                    });
                  }),
                ),

              // 메모
              _buildItemButton(
                '메모',
                _memo,
                () => _showInputDialog('메모', _memo, (value) {
                  setState(() {
                    _memo = value;
                  });
                }),
              ),

              const SizedBox(height: 20),
              // 저장 버튼
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: _saveData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    '저장하기',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeButton(String text, bool isIncome) {
    final bool isSelected = _isIncome == isIncome && _isIncome != null;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isIncome = isIncome;
          _category = '';
          _paymentMethod = '';
        });
        _initializeCategories();
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
            color: isSelected ? Colors.black : Colors.grey[700],
          ),
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
            Text(
              value.isEmpty ? label : value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
