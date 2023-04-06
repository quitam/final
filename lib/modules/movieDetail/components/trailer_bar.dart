import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/models/test_models.dart';
import 'package:flutter/material.dart';

class TrailerBar extends StatelessWidget {
  const TrailerBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: size.height / 5,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trailers.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Stack(
              children: [
                Container(
                  height: 160,
                  width: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(trailers[index].imagePath)),
                  ),
                ),
                Container(
                  height: 160,
                  width: 260,
                  decoration: const BoxDecoration(color: Colors.black26),
                ),
                GestureDetector(
                  onTap: () {
                    //play this trailer
                  },
                  child: SizedBox(
                    height: 160,
                    width: 260,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 56),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.blueMain),
                      child: const Icon(
                        Icons.play_arrow,
                        color: AppColors.white,
                      ),
                    ),
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
