enum GroupType {
  income,
  expense,
}

class Group {
  final int? id;
  final String name;
  final GroupType type;

  Group({
    this.id,
    required this.name,
    required this.type,
  });
}