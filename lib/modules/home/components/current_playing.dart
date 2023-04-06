import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/models/test_models.dart';
import 'package:final_project/modules/movieDetail/movie_detail_page.dart';
import 'package:flutter/material.dart';

class PlayingMoviesSlider extends StatelessWidget {
  const PlayingMoviesSlider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [movies[0], movies[5], movies[4]]
          .map((e) => Builder(builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(
                            movie: e,
                          ),
                        ));
                  },
                  child: Stack(
                    children: [
                      Hero(
                        tag: e.banner,
                        child: Container(
                          width: size.width,
                          padding: const EdgeInsets.only(left: 10, bottom: 24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(e.banner),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.gradientBlack1Start,
                                AppColors.gradientBlack1End,
                              ]),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            e.name,
                            style: AppTextStyles.heading18,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }))
          .toList(),
      options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
    );
  }
}
