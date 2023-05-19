import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/modules/movieDetail/movie_detail_page.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';

class MovieFilter extends StatefulWidget {
  final String stringToSearch;
  final List<Movie> movies;
  const MovieFilter(
      {super.key, required this.movies, required this.stringToSearch});
  @override
  State<MovieFilter> createState() => _MovieFilterState();
}

class _MovieFilterState extends State<MovieFilter> {
  bool isMoviePlaying(Movie movie) {
    return movie.releaseDate.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.darkerBackground,
          elevation: 0,
          title: Text(
            'Kết quả tìm kiếm "${widget.stringToSearch}"',
            style: AppTextStyles.heading18,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20, top: 20),
          height: size.height,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(
                        isPlaying: isMoviePlaying(widget.movies[index]),
                        movie: widget.movies[index],
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder(
                        future: getImageUrl(widget.movies[index].posterUrl),
                        builder: (context, snapshot) {
                          if (!snapshot.hasError && snapshot.hasData) {
                            String imageURL = snapshot.data ?? "";
                            return Container(
                              alignment: Alignment.centerLeft,
                              width: size.width / 3.5,
                              child: Image(
                                image: NetworkImage(imageURL),
                                fit: BoxFit.cover,
                              ),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 8),
                                width: size.width,
                                child: Text(
                                  widget.movies[index].name,
                                  style: AppTextStyles.heading20,
                                )),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 8),
                              width: size.width,
                              child: Text(
                                  'Thời lượng: ${widget.movies[index].duration} phút',
                                  style: AppTextStyles.normal16
                                      .copyWith(color: AppColors.grey)),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 8),
                              width: size.width,
                              child: Text(
                                  'Tình trạng: ${(isMoviePlaying(widget.movies[index])) ? "đang chiếu" : "sắp chiếu"}',
                                  style: AppTextStyles.normal16
                                      .copyWith(color: AppColors.grey)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
