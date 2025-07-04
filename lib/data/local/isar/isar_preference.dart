import 'package:isar/isar.dart';
import 'package:kkugit/data/model/preference.dart';
import 'package:kkugit/data/model/preference_data.dart';

part 'isar_preference.g.dart';

@collection
class IsarPreference {
  Id id = Isar.autoIncrement;
  late String name; // 설정 이름
late String data; // 설정 값 (JSON)
  late String type; // 설정 타입 (예: 'string', 'int', 'bool', 'list')

  Preference toDomain() {
    PreferenceData parsedData;
    switch (type) {
      case 'string':
        parsedData = StringData(data);
        break;
      case 'int':
        parsedData = IntData(int.parse(data));
        break;
      case 'bool':
        parsedData = BoolData(data.toLowerCase() == 'true');
        break;
      case 'list':
        parsedData = ListData(data.split(','));
        break;
      default:
        throw Exception('Unknown preference type: $type');
    }

    return Preference(
      id: id,
      name: name,
      data: parsedData,
    );
  }

  static IsarPreference fromDomain(Preference preference) {
    String data;
    String type;

    if (preference.data is StringData) {
      data = (preference.data as StringData).value;
      type = 'string';
    } else if (preference.data is IntData) {
      data = (preference.data as IntData).value.toString();
      type = 'int';
    } else if (preference.data is BoolData) {
      data = (preference.data as BoolData).value.toString();
      type = 'bool';
    } else if (preference.data is ListData) {
      data = (preference.data as ListData).value.join(',');
      type = 'list';
    } else {
      throw Exception('Unknown preference data type');
    }

    return IsarPreference()
      ..id = preference.id ?? Isar.autoIncrement
      ..name = preference.name
      ..data = data
      ..type = type;
  }


}