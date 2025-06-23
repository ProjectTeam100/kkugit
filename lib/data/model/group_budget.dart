class GroupBudget {
  final int? id; // 그룹 ID
  final String name; // 그룹 이름
  final int budget; // 그룹 예산

  GroupBudget({
    this.id,
    required this.name,
    required this.budget,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'budget': budget,
    };
  }

  factory GroupBudget.fromJson(Map<String, dynamic> json) {
    return GroupBudget(
      id: json['id'] as int,
      name: json['name'] as String,
      budget: json['budget'] as int,
    );
  }
}