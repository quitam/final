import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
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
    return StreamBuilder(
      stream: getPlayingMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final playingMovies = snapshot.data!;
          return CarouselSlider.builder(
            itemCount: playingMovies.length,
            itemBuilder: (context, index, realIndex) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(
                        isPlaying: true,
                        movie: playingMovies[index],
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    FutureBuilder(
                      future: getImageUrl(playingMovies[index].bannerUrl),
                      builder: (context, snapshot) {
                        if (!snapshot.hasError && snapshot.hasData) {
                          String image = snapshot.data ?? "";
                          return Hero(
                            tag: playingMovies[index].bannerUrl,
                            child: Container(
                              width: size.width,
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 24),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(image),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox(height: 0, width: 0);
                        }
                      },
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
                          playingMovies[index].name,
                          style: AppTextStyles.heading18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            options: CarouselOptions(autoPlay: true, enlargeCenterPage: true),
          );
        } else {
          return const SizedBox(height: 0, width: 0);
        }
      },
    );
  }
}
