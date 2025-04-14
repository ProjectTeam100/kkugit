import 'package:flutter/material.dart';

class Popup extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String? cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Widget? image;
  final Widget? customContent;

  const Popup({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    this.cancelText,
    required this.onConfirm,
    this.onCancel,
    this.image,
    this.customContent,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (image != null) ...[
            image!,
            const SizedBox(height: 10),
          ],
          Text(content, style: const TextStyle(fontSize: 16)),
          if (customContent != null) ...[
            const SizedBox(height: 10),
            customContent!,
          ],
        ],
      ),
      actions: [
        if (cancelText != null)
          TextButton(
            onPressed: onCancel ?? () => Navigator.of(context).pop(),
            child: Text(cancelText!, style: const TextStyle(color: Colors.red)),
          ),
        ElevatedButton(
          onPressed: onConfirm,
          child: Text(confirmText),
        ),
      ],
    );
  }
}

void showPopup({
  required BuildContext context,
  required String title,
  required String content,
  required String confirmText,
  String? cancelText,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  Widget? image,
  Widget? customContent,
}) {
  showDialog(
    context: context,
    barrierDismissible: true, // 배경 클릭 시 팝업 닫기
    barrierColor: Colors.black54,
    builder: (context) => Popup(
      title: title,
      content: content,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm ?? () => Navigator.of(context).pop(),
      onCancel: onCancel ?? () => Navigator.of(context).pop(),
      image: image,
      customContent: customContent,
    ),
  );
}
