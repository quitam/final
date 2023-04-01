import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/constants/asset_path.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: size.height / 3.5,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(AssetPath.teaserTrailer)),
              gradient: LinearGradient(colors: [
                AppColors.darkerBackground,
                AppColors.darkBackground
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            )),
        Container(
          height: 200,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            AppColors.darkBackground,
            AppColors.darkerBackground
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        )
      ],
    );
  }
}
