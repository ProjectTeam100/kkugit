import 'dart:developer' as console show log;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kkugit/data/constant/preference_name.dart';
import 'package:kkugit/data/model/preference_data.dart';
import 'package:kkugit/data/service/preference_service.dart';
import 'package:kkugit/di/injection.dart';
import 'package:kkugit/util/db/backup_util.dart';
import 'package:kkugit/util/permission/request_android_permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restart_app/restart_app.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _preferenceService = getIt<PreferenceService>();
  final _backupUtil = getIt<BackupUtil>();
  final reminderTimeRegex = RegExp(r'(\d{1,2}):(\d{1,2})\s([PAMpam]+)');

  bool isReminderOn = false;
  TimeOfDay reminderTime = const TimeOfDay(hour: 21, minute: 0);

  bool isAppLockOn = false; // 🔒 앱 잠금 스위치 상태

  /// 알림 시간 선택
  void _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: reminderTime,
    );
    if (picked != null) {
      final now = DateTime.now();
      final timeString = DateFormat.jm().format(
        DateTime(now.year, now.month, now.day, picked.hour, picked.minute),
      );
      await _preferenceService.updateByName(
        PreferenceName.reminderTime,
        StringData(timeString),
      );
      setState(() {
        reminderTime = picked;
      });
    }
  }

  /// 알림 권한 확인 및 요청
  Future<bool> _requestNotiPermissions() async {
    final notificationStatus = await Permission.notification.status;
    final scheduleExactAlarmStatus = await Permission.scheduleExactAlarm.status;
    bool result = false;
    if (notificationStatus.isDenied || scheduleExactAlarmStatus.isDenied) {
      result = await RequestAndroidPermissions.requestPermissions([
        Permission.notification,
        Permission.scheduleExactAlarm,
      ]);
    } else {
      result = true;
    }
    return result;
  }

  /// 저장소 권한 확인 및 요청
  Future<bool> _requestStoragePermissions() async {
    final manageExternalStorageStatus =
    await Permission.manageExternalStorage.status;
    if (manageExternalStorageStatus.isDenied) {
      return RequestAndroidPermissions.requestPermissions([
        Permission.manageExternalStorage,
      ]);
    }
    return true;
  }

  /// 데이터 백업
  Future<void> _backupData() async {
    final hasPermission = await _requestStoragePermissions();
    if (!hasPermission) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('저장소 권한이 필요합니다.')),
      );
      return;
    }
    final basePath = BackupUtil.backupFilePath;
    final dateCode = DateTime.now()
        .toIso8601String()
        .replaceAll(':', '-')
        .replaceAll('T', '_');
    console.log('백업 파일 이름: kkugit_$dateCode.isar');
    final backupPath = '$basePath/kkugit_$dateCode.isar';
    await _backupUtil.saveBackup(backupPath);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('데이터가 백업되었습니다: $backupPath')),
    );
  }

  /// 데이터 불러오기
  Future<void> _restoreData() async {
    final hasPermission = await _requestStoragePermissions();
    if (!hasPermission) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('저장소 권한이 필요합니다.')),
      );
      return;
    }
    final basePath = BackupUtil.backupFilePath;
    final pickedFile = await FilePicker.platform.pickFiles(
      initialDirectory: basePath,
      dialogTitle: '백업 파일 선택',
    );

    if (pickedFile == null || pickedFile.files.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('백업 파일을 선택하지 않았습니다.')),
      );
      return;
    }

    final backupFile = pickedFile.files.single.path.toString();

    try {
      await _backupUtil.loadBackup(backupFile);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('데이터 불러오기 완료'),
            content: const Text('데이터를 성공적으로 불러왔습니다. 변경사항을 적용하려면 앱을 재시작해주세요.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Restart.restartApp();
                },
                child: const Text('확인'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('취소'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      console.log('데이터 불러오기 실패: $e');
      if (!mounted) return;
      final errorMessage =
      e is Exception ? e.toString() : '데이터 불러오기 중 오류가 발생했습니다.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  /// 앱 시작 시 설정 불러오기
  Future<void> _loadPreferences() async {
    final preferences = await _preferenceService.getAll();
    for (var preference in preferences) {
      switch (preference.name) {
        case PreferenceName.enableReminder:
          isReminderOn = (preference.data as BoolData).value;
          break;
        case PreferenceName.reminderTime:
          final timeString = (preference.data as StringData).value;
          final DateFormat formatter = DateFormat.jm();
          try {
            final time = formatter.parse(timeString);
            reminderTime = TimeOfDay.fromDateTime(time);
          } catch (e) {
            reminderTime = const TimeOfDay(hour: 21, minute: 0);
          }
          break;
        case PreferenceName.enablePasscode: // 🔒 앱 잠금 설정 불러오기
          isAppLockOn = (preference.data as BoolData).value;
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
          SwitchListTile(
            title: const Text('앱 잠금 설정'),
            value: isAppLockOn,
            onChanged: (value) async {
              await _preferenceService.updateByName(
                PreferenceName.enablePasscode,
                BoolData(value),
              );
              setState(() {
                isAppLockOn = value;
              });
            },
          ),
          _buildSectionHeader('알림'),
          SwitchListTile(
            title: const Text('리마인더 설정'),
            value: isReminderOn,
            onChanged: (value) {
              if (value) {
                _requestNotiPermissions().then((granted) {
                  if (!granted && context.mounted) {
                    isReminderOn = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('알림 권한이 필요합니다.'),
                      ),
                    );
                  }
                });
              }
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
            _backupData();
            break;
          case PreferenceName.restoreData:
            _restoreData();
            break;
          default:
            break;
        }
      },
    );
  }
}
