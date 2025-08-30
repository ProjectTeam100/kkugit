import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: PinSetupScreen()));
}

class PinSetupScreen extends StatefulWidget {
  const PinSetupScreen({super.key});

  @override
  State<PinSetupScreen> createState() => _PinSetupScreenState();
}

class _PinSetupScreenState extends State<PinSetupScreen> {
  String firstPin = '';
  String confirmPin = '';
  bool isConfirm = false;

  void addDigit(String digit) {
    setState(() {
      if (!isConfirm) {
        if (firstPin.length < 4) firstPin += digit;
        if (firstPin.length == 4) isConfirm = true;
      } else {
        if (confirmPin.length < 4) confirmPin += digit;
        if (confirmPin.length == 4) checkPin();
      }
    });
  }

  void deleteDigit() {
    setState(() {
      if (!isConfirm) {
        if (firstPin.isNotEmpty) firstPin = firstPin.substring(0, firstPin.length - 1);
      } else {
        if (confirmPin.isNotEmpty) confirmPin = confirmPin.substring(0, confirmPin.length - 1);
      }
    });
  }

  void checkPin() {
    if (firstPin == confirmPin) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("PIN 설정 완료!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("PIN이 일치하지 않습니다.")));
      setState(() {
        firstPin = '';
        confirmPin = '';
        isConfirm = false;
      });
    }
  }

  Widget buildPinDots(String pin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          margin: const EdgeInsets.all(8),
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < pin.length ? Colors.black : Colors.grey[300],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    String displayText = !isConfirm ? '사용할 암호를 입력해 주세요.' : '확인을 위해 한번 더 입력해 주세요.';
    String currentPin = !isConfirm ? firstPin : confirmPin;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('암호 입력', style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(displayText, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 32),
          buildPinDots(currentPin),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.builder(
              itemCount: 12,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                if (index == 9) return buildKey('취소', () => setState(() { firstPin = ''; confirmPin = ''; isConfirm = false; }));
                if (index == 10) return buildKey('0', () => addDigit('0'));
                if (index == 11) return buildKey('←', deleteDigit);
                return buildKey('${index + 1}', () => addDigit('${index + 1}'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildKey(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: Text(label, style: const TextStyle(fontSize: 24))),
      ),
    );
  }
}
