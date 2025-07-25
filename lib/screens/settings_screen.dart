import 'package:flutter/material.dart';
import 'package:kkugit/data/constant/preference_name.dart';
import 'package:kkugit/data/model/preference_data.dart';
import 'package:kkugit/data/service/preference_service.dart';
import 'package:kkugit/di/injection.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _preferenceService = getIt<PreferenceService>();
  final reminderTimeRegex = RegExp(r'(\d{1,2}):(\d{1,2})\s([PAMpam]+)');
  bool isReminderOn = false;
  TimeOfDay reminderTime = const TimeOfDay(hour: 21, minute: 0);

  void _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: reminderTime,
    );
    if (picked != null) {
      final timeString =
          '${picked.hour}:${picked.minute} ${picked.hour >= 12 ? 'PM' : 'AM'}';
      await _preferenceService.updateByName(
        PreferenceName.reminderTime,
        StringData(timeString),
      );
      setState(() {
        reminderTime = picked;
      });
    }
  }

  // 앱 시작 시 설정 불러오기
  Future<void> _loadPreferences() async {
    final preferences = await _preferenceService.getAll();
    for (var preference in preferences) {
      switch (preference.name) {
        case PreferenceName.enableReminder:
          isReminderOn = (preference.data as BoolData).value;
          break;
        case PreferenceName.reminderTime:
          final timeString = (preference.data as StringData).value;
          final match = reminderTimeRegex.firstMatch(timeString);
          if (match != null) {
            final hour = int.parse(match.group(1)!);
            final minute = int.parse(match.group(2)!);
            final period = match.group(3)?.toUpperCase();
            if (period == 'PM' && hour < 12) {
              reminderTime = TimeOfDay(hour: hour + 12, minute: minute);
            } else if (period == 'AM' && hour == 12) {
              reminderTime = TimeOfDay(hour: 0, minute: minute);
            } else {
              reminderTime = TimeOfDay(hour: hour, minute: minute);
            }
          }
          break;
        default:
          break;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildSectionHeader('데이터'),
          _buildListTile('데이터 백업', PreferenceName.backupData),
          _buildListTile('데이터 불러오기', PreferenceName.restoreData),

          _buildSectionHeader('보안'),
          _buildListTile('앱 잠금 설정', PreferenceName.enablePasscode),

          _buildSectionHeader('알림'),
          SwitchListTile(
            title: const Text('리마인더 설정'),
            value: isReminderOn,
            onChanged: (value) {
              _preferenceService.updateByName(
                PreferenceName.enableReminder,
                BoolData(value),
              );
              setState(() {
                isReminderOn = value;
              });
            },
          ),
          ListTile(
            title: const Text('알림 시간'),
            trailing: Text(reminderTime.format(context)),
            onTap: _pickTime,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      color: Colors.grey[300],
      padding: const EdgeInsets.all(12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListTile(String title, PreferenceName? name) {
    return ListTile(
      title: Text(title),
      onTap: () {
        switch (name) {
          case PreferenceName.backupData:
            //TODO: 데이터 백업 기능 구현
            break;
          case PreferenceName.restoreData:
            //TODO: 데이터 불러오기 기능 구현
            break;
          case PreferenceName.enablePasscode:
            //TODO: 앱 잠금 설정 기능 구현
            break;
          default:
            break;
        }
      },
    );
  }
}
