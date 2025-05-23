import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:kkugit/data/model/category.dart';

class CategoryEditScreen extends StatefulWidget {
  final bool isIncome;

  const CategoryEditScreen({super.key, required this.isIncome});

  @override
  State<CategoryEditScreen> createState() => _CategoryEditScreenState();
}

class _CategoryEditScreenState extends State<CategoryEditScreen> {
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final box = await Hive.openBox<Category>('categoryBox');
    setState(() {
      _categories =
          box.values.where((c) => c.isIncome == widget.isIncome).toList();
    });
  }

  void _deleteCategory(int index) async {
    await _categories[index].delete();
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
              category.name = controller.text;
              await category.save();
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
              if (name.isNotEmpty) {
                final box = Hive.box<Category>('categoryBox');
                final newCategory = Category(
                  id: DateTime.now().millisecondsSinceEpoch,
                  name: name,
                  isIncome: widget.isIncome,
                );
                await box.add(newCategory);
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
    return Scaffold(
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
                  onPressed: () => _deleteCategory(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
