import 'package:isar/isar.dart';
import 'package:kkugit/data/model/transaction.dart';

part 'isar_transaction.g.dart';

@collection
class IsarTransaction {
  Id id = Isar.autoIncrement;
  late DateTime dateTime; // 거래 날짜
  late String client; // 거래처
  late String payment; // 결제 수단
  late int categoryId; // 카테고리 id
  late int? groupId; // 그룹 id
  late int amount; // 거래 금액
  late String memo; // 메모
  @enumerated
  late TransactionType type; // 거래 유형 (수입/지출)

Transaction toDomain() => Transaction(
    id: id,
    dateTime: dateTime,
    client: client,
    payment: payment,
    categoryId: categoryId,
    groupId: groupId,
    amount: amount,
    memo: memo,
    type: type,
  );

  static IsarTransaction fromDomain(Transaction transaction) {
    return IsarTransaction()
      ..id = transaction.id ?? Isar.autoIncrement
      ..dateTime = transaction.dateTime
      ..client = transaction.client
      ..payment = transaction.payment ?? ''
      ..categoryId = transaction.categoryId
      ..groupId = transaction.groupId
      ..amount = transaction.amount
      ..memo = transaction.memo
      ..type = transaction.type;
  }


}