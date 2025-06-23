enum CategoryType {
  INCOME, // 수입
  EXPENSE, // 지출
}

class Category {
  final int? id;
  String name;
  final CategoryType type;

  Category({
    this.id,
    required this.name,
    required this.type,
  });

  Category copyWith({required String name}) {
    return Category(
      id: this.id,
      name: name,
      type: this.type,
    );
  }
}