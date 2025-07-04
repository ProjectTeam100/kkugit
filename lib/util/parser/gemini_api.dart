import 'dart:convert';

import 'package:firebase_ai/firebase_ai.dart';

Future<Map<String, dynamic>> parseMessage(String message) async {
  if (message.isEmpty) {
    throw Exception('메시지가 비어있습니다.');
  }

  final generationConfig = GenerationConfig(
    responseMimeType: 'text/plain',
  );

  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemma-3n-e4b-it',
    generationConfig: generationConfig,
  );

  final promptText = """
    
    메시지 내용:
    [ $message ]

    ------

    선행 작업:
    만약 위의 메시지가 카드사 알림 문자가 아니거나, 카드사명 또는 금액이 인식되지 않으면 json을 만들지 말고, "유효한 형식이 아닙니다."라고만 대답하고, 아래의 명령을 무시해. 다른 말은 하지 말고, 오직 그 문장만 대답해.

    분석 요청:
    위 카드사 결제 알림 문자를 분석하여  
    카드명, 카드번호, 금액, 날짜, 시간, 결제처, 승인/취소 여부, 할부 또는 일시불 정보를 각각 키-값 쌍을 가진 문자열로 출력해줘.
    카드번호는 문자에 카드사명9999 또는 카드사명(9999) 이런 식으로 기재된 4자리 숫자를 추출하면 돼.
    카드이름은 카드사명을 추출해서 "{카드사명}카드" 형태로 만들어줘.
    날짜는 MM-DD 형식으로, 시간은 HH:mm 형식으로 작성해줘
    백틱 (```)이나 따옴표(''), 공백이나 줄바꿈 없이 { "key": "value" } 형태로 써줘. json 형이 아닌, 중괄호로 둘러싸인 "문자열"로만 작성하면 돼.
    형식 : { cardName: string, cardNumber: 4자리 숫자 string, date: string (MM-DD), time: string (HH:mm), client: 결제처 string, type: 승인, 취소 등, amount: 결제금액 기호와 단위를 제외한 숫자만, installment: 할부 개월수 숫자(일시불일 경우 0), }
  """;

  final response = await model.generateContent([Content.text(promptText)]);
  final jsonResponse = response.text?.trim();
  if (jsonResponse == null || jsonResponse.isEmpty) {
    throw Exception('응답이 비어있습니다.');
  }
  try {
    final match = RegExp(r'\{.*?\}').firstMatch(jsonResponse);
    if (match == null) {
      throw Exception('유효한 JSON 형식이 아닙니다.');
    }
    final parsedJson = match.group(0)!.replaceAll('\n', '').replaceAll(' ', '');
    final Map<String, dynamic> result = json.decode(parsedJson);
    return result;
  } catch (e) {
    throw Exception('JSON 파싱 오류: $e');
  }
}
