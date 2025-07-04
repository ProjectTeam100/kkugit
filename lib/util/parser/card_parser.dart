// 카드 알림 문자 파싱
import 'package:kkugit/data/model/transaction.dart';

const typeMap = {
  '승인': TransactionType.expense,
  '취소': TransactionType.income,
};

TransactionType getTransactionType(String? type) {
  return typeMap[type] ?? TransactionType.expense; // 기본값은 지출
}

abstract class CardParser { // 기본 추상 클래스
  CardParser? next;

  Transaction? parse(String message);

  CardParser setNext(CardParser nextParser) {
    next = nextParser;
    return nextParser;
  }

  Transaction? handle(String message) {
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
;

class SamsungCardParser extends CardParser {
  @override
  Transaction? parse(String message) {
    // 삼성카드 알림 문자 파싱 로직
    if (!message.contains('삼성')) {
      return null; // 삼성카드가 아닌 경우
    }

    final cardNumberAndType = RegExp(r'삼성(\d{4})([ㄱ-ㅣ가-힣]+)').firstMatch(message);
    final amountAndInstall = RegExp(r'(\d{1,3}(?:,\d{3})*)원\s*([ㄱ-ㅣ가-힣]+)').firstMatch(message);
    final dateTimeAndClient = RegExp(r'(\d{2}/\d{2})\s*(\d{2}:\d{2})\s*([\s\S]*)\s').firstMatch(message);

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
      type: getTransactionType(paymentType)
    );
  }
}