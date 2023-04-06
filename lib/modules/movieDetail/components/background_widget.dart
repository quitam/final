import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/models/test_models.dart';
import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Movie movie;
  const BackgroundWidget({
    super.key,
    required this.size,
    required this.movie,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: movie.banner,
          child: Container(
              height: size.height / 3.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(movie.banner)),
                gradient: const LinearGradient(colors: [
                  AppColors.darkerBackground,
                  AppColors.darkBackground
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              )),
        ),
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
