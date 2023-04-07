import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/models/test_models.dart';
import 'package:flutter/material.dart';

class TimeBar extends StatelessWidget {
  const TimeBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: size.height / 15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: times.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(right: 14),
          alignment: Alignment.center,
          width: size.width / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.darkBackground,
          ),
          child: Text(
            times[index].time,
            style: AppTextStyles.heading20,
          ),
        ),
      ),
    );
  }
}
