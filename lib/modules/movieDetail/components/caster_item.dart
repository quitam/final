import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/models/models.dart';
import 'package:flutter/material.dart';

class CasterItem extends StatelessWidget {
  final List<Actor> actors;
  const CasterItem({
    super.key,
    required this.size,
    required this.actors,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: actors.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 4),
              child: FutureBuilder(
                future: getImageUrl(actors[index].image),
                builder: (context, snapshot) {
                  String image = snapshot.data ?? "";
                  return image != "" ? Container(
                    width: size.width / 4.5,
                    height: size.width / 4.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.scaleDown  
                      ),
                    ),
                  ) : Container(height: 0, width: 0);
                },
              ),
            ),
            Text(
              actors[index].name,
              style: AppTextStyles.normal16.copyWith(color: AppColors.grey),
              overflow: TextOverflow.clip,
            )
          ],
        );
      },
    );
  }
}
