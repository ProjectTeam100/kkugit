import 'package:flutter/material.dart';
import 'package:kkugit/data/model/category.dart';
import 'package:kkugit/data/service/category_service.dart';
import 'package:kkugit/di/injection.dart';

class CategoryEditScreen extends StatefulWidget {
  final bool isIncome;

  const CategoryEditScreen({super.key, required this.isIncome});

  @override
  State<CategoryEditScreen> createState() => _CategoryEditScreenState();
}

class _CategoryEditScreenState extends State<CategoryEditScreen> {
  final _categoryService = getIt<CategoryService>();
  List<Category> _incomeCategories = [];
  List<Category> _expenseCategories = [];
  List<Category> get _categories =>
      widget.isIncome ? _incomeCategories : _expenseCategories; // 현재 화면에 맞는 카테고리 리스트

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async { // 수입, 지출 카테고리 불러오기
    _incomeCategories = await _categoryService.getByType(CategoryType.income);
    _expenseCategories = await _categoryService.getByType(CategoryType.expense);
  }

  void _deleteCategory(int id) async {
    _categoryService.delete(id);
    _loadCategories();
  }

  void _editCategory(Category category) {
    final controller = TextEditingController(text: category.name);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('카테고리 이름 수정'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: '새 이름을 입력하세요'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('취소')),
          TextButton(
            onPressed: () async {
              Category newCategory = category.copyWith( // 수정된 카테고리 생성
                name: controller.text.trim(),
              );
              _categoryService.update(newCategory);
              if (!mounted) return;
              Navigator.pop(context, true);
              _loadCategories();
            },
            child: const Text('저장'),
          ),
        ],
      ),
    );
  }

  void _addCategory() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('새 카테고리 추가'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: '카테고리 이름 입력'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('취소')),
          TextButton(
            onPressed: () async {
              final name = controller.text.trim();
              if (name.isNotEmpty) { // 이름이 중복되는 카테고리 확인 로직 필요
                _categoryService.add(
                  name,
                  widget.isIncome ? CategoryType.income : CategoryType.expense
                );
                await _loadCategories();
                if (!mounted) return;
                Navigator.pop(context, true);
              }
            },
            child: const Text('추가'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // PopScope를 사용해서 뒤로가기 눌렀을 때 결과를 처리
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context, true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.isIncome ? '수입 카테고리 편집' : '지출 카테고리 편집'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _addCategory,
            )
          ],
        ),
        body: ListView.separated(
          itemCount: _categories.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final category = _categories[index];
            return ListTile(
              title: Text(category.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _editCategory(category),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteCategory(category.id!),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
