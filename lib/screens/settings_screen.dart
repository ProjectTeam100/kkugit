import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isReminderOn = false;
  TimeOfDay reminderTime = const TimeOfDay(hour: 21, minute: 0);

  void _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: reminderTime,
    );
    if (picked != null) {
      setState(() {
        reminderTime = picked;
      });
    }
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
          _buildListTile('데이터 백업'),
          _buildListTile('데이터 불러오기'),

          _buildSectionHeader('보안'),
          _buildListTile('앱 잠금 설정'),

          _buildSectionHeader('알림'),
          SwitchListTile(
            title: const Text('리마인더 설정'),
            value: isReminderOn,
            onChanged: (value) {
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

  Widget _buildListTile(String title) {
    return ListTile(
      title: Text(title),
      onTap: () {
        // TODO: 원하는 동작 연결
      },
    );
  }
}
