import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/modules/movieDetail/movie_detail_page.dart';
import 'package:flutter/material.dart';

class UpComing extends StatelessWidget {
  const UpComing({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getMax5UpComingMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.hasError) {
          final upcomingMovies = snapshot.data!;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: upcomingMovies.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailPage(
                            isPlaying: false,
                            movie: upcomingMovies[index],
                          ),
                        ));
                  },
                  child: FutureBuilder(
                      future: getImageUrl(upcomingMovies[index].bannerUrl),
                      builder: (context, snapshot) {
                        if (!snapshot.hasError && snapshot.hasData) {
                          String image = snapshot.data ?? "";
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            alignment: Alignment.center,
                            width: 120,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.white),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(image),
                                    fit: BoxFit.cover)),
                          );
                        } else {
                          return const Center(
                            child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator()),
                          );
                        }
                      }),
                );
              },
            ),
          );
        } else {
          return const SizedBox(height: 0, width: 0);
        }
      },
    );
  }
}
