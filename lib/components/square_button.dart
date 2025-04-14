import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double paddingVertical;
  final double paddingHorizontal;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final double elevation;

  const SquareButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.borderColor = const Color(0xFF5199FF),
    this.paddingVertical = 10,
    this.paddingHorizontal = 20,
    this.borderRadius = 8,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor), // 테두리 색상
        padding: EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: elevation,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
