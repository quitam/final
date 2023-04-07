import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/models/test_models.dart';
import 'package:flutter/material.dart';

class DateBar extends StatelessWidget {
  const DateBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: size.height / 8,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            height: size.height / 8,
            width: size.width / 5,
            decoration: BoxDecoration(
                color: AppColors.darkBackground,
                borderRadius: BorderRadius.circular(14)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  days[index].day,
                  style: AppTextStyles.heading28,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    days[index].dd.toString().padLeft(2, '0'),
                    style: AppTextStyles.heading28,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
