import 'package:echirp/utils/global_variables.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    required this.text,
    required this.size,
    required this.onPressed,
    this.height,
    this.width,
    this.textSize,
  });

  final Size size;
  final String text;
  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final double? textSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width ?? size.width * 0.2,
          vertical: height ?? size.height * 0.018,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            // color: Colors.white,
            gradient: GlobalVariables.colors.primaryGradient),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: textSize ?? 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
