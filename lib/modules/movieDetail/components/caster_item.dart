import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/models/test_models.dart';
import 'package:flutter/material.dart';

class CasterItem extends StatelessWidget {
  final TestMovie movie;
  const CasterItem({
    super.key,
    required this.size,
    required this.movie,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: movie.casters.length,
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
                        image: AssetImage(movie.casters[index]['imagePath'])),
                  ),
                )),
            Text(
              movie.casters[index]['nameCast'],
              style: AppTextStyles.normal16.copyWith(color: AppColors.grey),
            )
          ],
        );
      },
    );
  }
}
