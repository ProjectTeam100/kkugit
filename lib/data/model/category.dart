enum CategoryType {
  income, // 수입
  expense, // 지출
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
      id: id,
      name: name,
      type: type,
    );
  }
}