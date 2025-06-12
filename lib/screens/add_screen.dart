import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kkugit/data/model/category.dart';
import 'package:hive/hive.dart';
import 'package:kkugit/data/model/income.dart';
import 'package:kkugit/data/model/spending.dart';
import 'package:kkugit/screens/category_edit_screen.dart';
import 'package:kkugit/data/service/income_service.dart';
import 'package:kkugit/data/service/spending_service.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final SpendingService _spendingService = SpendingService();
  final IncomeService _incomeService = IncomeService();
  final TextEditingController _amountController = TextEditingController();
  bool? _isIncome; // null은 선택되지 않은 상태
  final DateTime _selectedDate = DateTime.now();
  final FocusNode _amountFocusNode = FocusNode();
  String transactionType = 'expense'; // 'income' or 'expense'

  @override
  void dispose() {
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  void _showDetailInputPage() {
    if (_isIncome == null) {
      // 수입/지출 선택하지 않은 경우
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('수입 또는 지출을 선택해주세요')),
      );
      return;
    }

    if (_amountController.text.isEmpty) {
      // 금액 입력하지 않은 경우
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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailInputScreen(
          amount: _amountController.text,
          isIncome: _isIncome!,
          date: _selectedDate,
        ),
      ),
    ).then((result) {
      if (result == true) {
        Navigator.pop(context, true); // 데이터 저장 후 이전 화면으로 돌아가기
      }
    });
  }

  void _showRecurringInstallmentOptions() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('반복/할부 선택'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('반복 설정'),
              onTap: () {
                Navigator.pop(context);
                _showRecurringOptions();
              },
            ),
            ListTile(
              title: const Text('할부 설정'),
              onTap: () {
                Navigator.pop(context);
                _showInstallmentOptions();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
        ],
      ),
    );
  }

  void _showRecurringOptions() {
    // 반복 설정 관련 다이얼로그 표시
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('반복 설정'),
        content: const Text('반복 주기 설정'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              // 반복 설정 저장 로직
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('반복 설정이 저장되었습니다')),
              );
            },
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }

  void _showInstallmentOptions() {
    // 할부 설정 관련 다이얼로그 표시
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('할부 설정'),
        content: const Text('할부 개월 수 설정'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              // 할부 설정 저장 로직
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('할부 설정이 저장되었습니다')),
              );
            },
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }

  void _saveData() {
    // 수입/지출 내역 저장
    final int amount = int.tryParse(_amountController.text) ?? 0;

    if (amount <= 0) {
      // 금액이 0 이하인 경우 처리
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('금액을 입력하세요.'),
        ),
      );
      return;
    }

    // 수입/지출에 따라 객체 생성 및 저장
    if (transactionType == 'income') {
      // 수입 객체 생성 및 저장
      final income = Income(
        id: DateTime.now().millisecondsSinceEpoch,
        dateTime: _selectedDate,
        client: '내역', //임시 값
        category: 1, //임시 카테고리 id
        group: 1, //임시 그룹 id
        price: amount,
        memo: '메모', //임시 메모
      );

      _incomeService.addIncome(income); // 수입 저장
    } else {
      // 지출 객체 생성 및 저장
      final spending = Spending(
        id: DateTime.now().millisecondsSinceEpoch,
        dateTime: _selectedDate,
        client: '내역', //임시 값
        payment: '현금', //임시 값
        category: 1, //임시 카테고리 id
        group: 1, //임시 그룹 id
        price: amount,
        memo: '메모', //임시 메모
      );
      _spendingService.addSpending(spending); // 지출 저장
    }
    // 저장 완료 메시지
    if (_isIncome == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('수입 또는 지출을 선택해주세요')),
      );
      return;
    } else {
      final String typeText = _isIncome! ? '수입' : '지출';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$typeText 데이터가 저장되었습니다.')),
    );
    }

    // 이전 화면으로 돌아가기
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
              child: const Text('날짜',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: _showRecurringInstallmentOptions,
              child: const Text(
                '반복/할부',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true, // 키보드가 올라올 때 화면 리사이징
      body: Column(
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
                        }),
                  ),
                ],
              ),
            ),
          ),

          // 수입/지출 버튼
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

          // 하단 메뉴 바는 Expanded로 감싸서 아래쪽에 고정되도록 함
          const Spacer(),

          // 버튼 바
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomMenuItem('문자 불러보기'),
                _buildBottomMenuItem('영수증'),
                _buildBottomMenuItem('확인', onTap: _showDetailInputPage),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeButton(String text, bool isIncome) {
    final bool isSelected = _isIncome == isIncome && _isIncome != null;

    return GestureDetector(
      onTap: () {
        setState(() {
          _isIncome = isIncome;
        });
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

  Widget _buildBottomMenuItem(String text, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// 상세 정보 입력 화면
class DetailInputScreen extends StatefulWidget {
  final String amount;
  final bool isIncome;
  final DateTime date;

  const DetailInputScreen({
    super.key,
    required this.amount,
    required this.isIncome,
    required this.date,
  });

  @override
  State<DetailInputScreen> createState() => _DetailInputScreenState();
}

class _DetailInputScreenState extends State<DetailInputScreen> {
  String _description = '';
  String _category = '';
  String _group = '';
  String _paymentMethod = '';
  String _memo = '';
  List<Category> _categories = [];
  bool _isCategoryExpanded = false;

  //카테고리 목록 가져오는 메서드
  @override
  void initState() {
    super.initState();
    _initializeCategories();
  }

  void _initializeCategories() async {
    if (!Hive.isBoxOpen('categoryBox')) {
      await Hive.openBox<Category>('categoryBox');
    }

    final box = Hive.box<Category>('categoryBox');
    final categories =
        box.values.where((cat) => cat.isIncome == widget.isIncome).toList();

    setState(() {
      _categories = [];
    });
    setState(() {
      _categories = categories;
    });
  }

  // 내역, 그룹, 결제수단, 메모 입력 다이얼로그
  void _showInputDialog(
      String title, String currentValue, Function(String) onSave) {
    final TextEditingController controller =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: '$title을(를) 입력하세요',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isIncome ? '수입 내역 입력' : '지출 내역 입력'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 금액 표시
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('금액',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(
                    '${widget.amount}원',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            // 수입/지출 선택 표시
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    decoration: BoxDecoration(
                      color:
                          widget.isIncome ? Colors.grey[400] : Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      '수입',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            widget.isIncome ? Colors.black : Colors.grey[700],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    decoration: BoxDecoration(
                      color: !widget.isIncome
                          ? Colors.grey[400]
                          : Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      '지출',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            !widget.isIncome ? Colors.black : Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 내역 버튼
            _buildItemButton(
                '내역',
                _description,
                () => _showInputDialog('내역', _description, (value) {
                      setState(() {
                        _description = value;
                      });
                    })),

            // 카테고리 버튼
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
                          children: _categories.map((category) {
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
                          }).toList()
                            ..add(
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CategoryEditScreen(
                                        isIncome: widget.isIncome,
                                      ),
                                    ),
                                  ).then((result) {
                                    if (result == true) {
                                      _initializeCategories();
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
                            ),
                        ),
                      ),
                  ],
                )),

            // 그룹 버튼
            _buildItemButton(
                '그룹',
                _group,
                () => _showInputDialog('그룹', _group, (value) {
                      setState(() {
                        _group = value;
                      });
                    })),

            // 결제 수단 버튼 (지출인 경우만)
            if (!widget.isIncome)
              _buildItemButton(
                  '결제수단',
                  _paymentMethod,
                  () => _showInputDialog('결제수단', _paymentMethod, (value) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      })),

            // 메모 버튼
            _buildItemButton(
                '메모',
                _memo,
                () => _showInputDialog('메모', _memo, (value) {
                      setState(() {
                        _memo = value;
                      });
                    })),

            const SizedBox(height: 20),

            // 저장 버튼
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () => {}, // AddScreen과 DetailInputScreen 합친 후에 _saveData 함수 호출
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
              label,
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
