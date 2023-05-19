import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/modules/movieDetail/movie_detail_page.dart';
import 'package:final_project/modules/movieFilter/drop_down.dart';
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

  int compareVietnameseStrings(String a, String b) {
    const String vietnameseAlphabet = 'aăâbcdđeêghiklmnoôơpqrstuưvxy';
    final int aLength = a.length;
    final int bLength = b.length;
    final int maxLength = aLength > bLength ? aLength : bLength;

    for (int i = 0; i < maxLength; i++) {
      final int aIndex = i < aLength ? vietnameseAlphabet.indexOf(a[i]) : -1;
      final int bIndex = i < bLength ? vietnameseAlphabet.indexOf(b[i]) : -1;

      if (aIndex != -1 && bIndex != -1) {
        if (aIndex < bIndex) {
          return -1;
        } else if (aIndex > bIndex) {
          return 1;
        }
      } else if (aIndex != -1) {
        return -1;
      } else if (bIndex != -1) {
        return 1;
      }
    }

    return 0;
  }

  void handleFilterCallback(String option) {
    setState(() {
      switch (option) {
        case "Tên":
          widget.movies.sort(((a, b) => compareVietnameseStrings(a.name.toLowerCase(), b.name.toLowerCase())));
          break;
        case "Thời gian chiếu":
          widget.movies
              .sort(((a, b) => a.releaseDate.compareTo(b.releaseDate)));
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget.movies.sort(((a, b) => a.releaseDate.compareTo(b.releaseDate)));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkerBackground,
        elevation: 0,
        title: Text(
          'Kết quả tìm kiếm "' + widget.stringToSearch + '"',
          style: AppTextStyles.normal16,
        ),
      ),
      body: Container(
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FilterDropDown(callback: handleFilterCallback),
            Container(
              height: size.height - 160,
              padding: const EdgeInsets.only(left: 20, top: 20),
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
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 8),
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
                                      'Tình trạng: ' +
                                          ((isMoviePlaying(
                                                  widget.movies[index]))
                                              ? "đang chiếu"
                                              : "sắp chiếu"),
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
            ),
          ],
        ),
      ),
    );
  }
}
