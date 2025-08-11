// 카드 알림 문자 파싱
import 'dart:async';
import 'dart:developer' as console show log;

import 'package:kkugit/data/model/transaction.dart';
import 'package:kkugit/util/parser/gemini_api.dart';

const typeMap = {
  '승인': TransactionType.expense,
  '취소': TransactionType.income,
};

TransactionType getTransactionType(String? type) {
  return typeMap[type] ?? TransactionType.expense; // 기본값은 지출
}

abstract class CardParser {
  // 기본 추상 클래스
  CardParser? next;

  FutureOr<Transaction?> parse(String message);

  CardParser setNext(CardParser nextParser) {
    next = nextParser;
    return nextParser;
  }

  FutureOr<Transaction?> handle(String message) {
    final transaction = parse(message);

    if (transaction != null) {
      return transaction;
    } else if (next != null) {
      return next!.handle(message);
    }
    return null;
  }
}

final cardParseChain = SamsungCardParser()
// ..setNext(BCCardParser())
//..setNext(NHCardParser())
    .setNext(AIParser()); // 순서대로 파싱 시도, 마지막에 AI 호출

// 파서 없을 경우 AI 호출
class AIParser extends CardParser {
  @override
  Future<Transaction?> parse(String message) async {
    try {
      final parsedData = await parseMessage(message);
      if (parsedData.isEmpty) return null;
      final year = DateTime.now().year.toString();
      console.log(parsedData['amount']);
      return Transaction(
        dateTime:
            DateTime.parse('$year-${parsedData['date']} ${parsedData['time']}'),
        client: parsedData['client'] ?? '',
        payment: parsedData['cardName'] ?? '카드',
        categoryId: 0, // 카테고리 ID는 추후에 설정
        groupId: null, // 그룹 ID는 추후에 설정
        amount:
            int.tryParse(parsedData['amount'].toString().replaceAll(',', '')) ??
                0,
        memo: '', // 메모는 추후에 설정
        type: getTransactionType(parsedData['type'] ?? ''),
      );
    } catch (e) {
      return null; // 파싱 실패 시 null 반환
    }
  }
}

class SamsungCardParser extends CardParser {
  @override
  Transaction? parse(String message) {
    // 삼성카드 알림 문자 파싱 로직
    if (!message.contains('삼성')) {
      return null; // 삼성카드가 아닌 경우
    }

    final cardNumberAndType =
        RegExp(r'삼성(\d{4})([ㄱ-ㅣ가-힣]+)').firstMatch(message);
    final amountAndInstall =
        RegExp(r'(\d{1,3}(?:,\d{3})*)원\s*([ㄱ-ㅣ가-힣]+)').firstMatch(message);
    final dateTimeAndClient =
        RegExp(r'(\d{2}/\d{2})\s*(\d{2}:\d{2})\s*([\s\S]*)\s')
            .firstMatch(message);

    // final cardNumber = cardNumberAndType?.group(0); // 카드번호
    final paymentType = cardNumberAndType?.group(2);
    final amount = amountAndInstall?.group(1)?.replaceAll(',', '');
    // final install = amountAndInstall?.group(2); // 할부정보 추후사용
    final date = dateTimeAndClient?.group(1)?.replaceAll('/', '-');
    final time = dateTimeAndClient?.group(2);
    final client = dateTimeAndClient?.group(3)?.trim();

    if (amount == null) return null; // 금액이 없으면 파싱 실패

    final year = DateTime.now().year.toString(); // 현재 연도를 사용

    return Transaction(
        dateTime: DateTime.parse('$year-$date $time'),
        client: client ?? '',
        payment: '카드',
        categoryId: 0, // 카테고리 ID는 추후에 설정
        groupId: null, // 그룹 ID는 추후에 설정
        amount: int.parse(amount),
        memo: '', // 메모는 추후에 설정
        type: getTransactionType(paymentType));
  }
}
