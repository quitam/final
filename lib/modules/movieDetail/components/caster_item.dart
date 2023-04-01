import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/models/test_models.dart';
import 'package:flutter/material.dart';

class CasterItem extends StatelessWidget {
  const CasterItem({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: casters.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 4),
                child: Container(
                  width: size.width / 4.5,
                  height: size.width / 4.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(casters[index].imagePath)),
                  ),
                )),
            Text(
              casters[index].name,
              style: AppTextStyles.normal16.copyWith(color: AppColors.grey),
            )
          ],
        );
      },
    );
  }
}
