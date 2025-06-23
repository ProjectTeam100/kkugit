enum TransactionType {
  INCOME, // 수입
  EXPENSE, // 지출
}

class Transaction {
  final int? id;
  final DateTime dateTime;
  final String client; // 내역
  final String payment; // 결제수단
  final int category; // 카테고리 id
  final int group; // 그룹 id
  final int amount; // 거래 금액
  final String memo; // 메모
  final TransactionType type; // 거래 유형 (수입/지출)

  Transaction({
    this.id,
    required this.dateTime,
    required this.client,
    required this.payment,
    required this.category,
    required this.group,
    required this.amount,
    required this.memo,
    required this.type,
  });
}