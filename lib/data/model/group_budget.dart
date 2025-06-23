class GroupBudget {
  final int? groupId; // 그룹 ID
  final int amount; // 그룹 예산

  GroupBudget({
    this.groupId,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'budget': amount,
    };
  }

  factory GroupBudget.fromJson(Map<String, dynamic> json) {
    return GroupBudget(
      groupId: json['groupId'] as int?,
      amount: json['amount'] as int,
    );
  }
}