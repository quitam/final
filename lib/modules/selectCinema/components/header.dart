import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({
    super.key,
    required this.size,
    required this.title,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 10,
      child: Center(
        child: Text(
          title,
          style: AppTextStyles.heading28,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
