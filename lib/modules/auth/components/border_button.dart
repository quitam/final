import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class BorderButton extends StatelessWidget {
  const BorderButton({
    super.key,
    required this.size,
    required this.onTap,
    required this.text,
    required this.backgroundColor,
    required this.borderColor,
  });
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final VoidCallback onTap;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width * 0.7,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(30)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: backgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: onTap,
              child: Text(
                text,
                style: AppTextStyles.heading18
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            )));
  }
}
