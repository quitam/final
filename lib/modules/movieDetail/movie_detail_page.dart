import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/modules/movieDetail/components/fa_button.dart';
import 'package:final_project/modules/movieDetail/components/background_widget.dart';
import 'package:final_project/modules/movieDetail/components/cast_bar.dart';
import 'package:final_project/modules/movieDetail/components/trailer_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MovieDetailPage extends StatefulWidget {
  final bool isPlaying;
  final Movie movie;
  const MovieDetailPage({
    super.key,
    required this.movie,
    required this.isPlaying,
  });

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      floatingActionButton: widget.isPlaying ? FAButton(widget: widget) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BackgroundWidget(
              size: size,
              movie: widget.movie,
            ),
            Container(
              height: size.height / 3.5,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(0, 11, 15, 47),
                AppColors.darkBackground
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: size.height / 4.5),
                  child: Row(
                    children: [
                      FutureBuilder(
                        future: getImageUrl(widget.movie.posterUrl),
                        builder: (context, snapshot) {
                          if (!snapshot.hasError && snapshot.hasData) {
                            String imageURL = snapshot.data ?? "";
                            return SizedBox(
                              width: size.width / 2.5,
                              child: Image(
                                image: NetworkImage(imageURL),
                                fit: BoxFit.cover,
                              ),
                            );
                          } else {
                            return const SizedBox(height: 0, width: 0);
                          }
                        },
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 8),
                                width: size.width,
                                child: Text(
                                  widget.movie.name,
                                  style: AppTextStyles.heading20,
                                )),
                            Container(
                                margin:
                                    const EdgeInsets.only(left: 8, bottom: 8),
                                child: Row(
                                  children: const [Text('Votes: unknown')],
                                )),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 8),
                              width: size.width,
                              child: StreamBuilder(
                                stream: getGenres(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasError && snapshot.hasData) {
                                    List<Genre> genres = snapshot.data!;
                                    return Text(
                                      getGenresAsSingleString(
                                          widget.movie, genres),
                                      style: AppTextStyles.normal16
                                          .copyWith(color: AppColors.green),
                                    );
                                  } else {
                                    return const Text("N/A");
                                  }
                                },
                              ),
                              // child: Text(
                              //   getGenresAsSingleString(widget.movie),
                              //   style: AppTextStyles.normal16
                              //       .copyWith(color: AppColors.green),
                              // ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 8, bottom: 8),
                              width: size.width,
                              child: Text(
                                  'Thời lượng: ${widget.movie.duration} phút',
                                  style: AppTextStyles.normal16
                                      .copyWith(color: AppColors.grey)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height - 120,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16),
                        alignment: Alignment.center,
                        width: size.width,
                        child: TabBar(
                          tabs: const [
                            Tab(
                              text: 'Thông Tin Phim',
                            ),
                            Tab(
                              text: 'Đánh Giá',
                            )
                          ],
                          controller: _tabController,
                          //indicatorSize: TabBarIndicatorSize.label,
                          labelStyle: AppTextStyles.heading18
                              .copyWith(fontWeight: FontWeight.w600),
                          unselectedLabelStyle: AppTextStyles.heading18,
                          indicatorColor: AppColors.white,
                          indicatorPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                        ),
                      ),
                      Flexible(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                buildTitle('Nội dung'),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    '   ${widget.movie.synopsis}',
                                    style: AppTextStyles.normal16
                                        .copyWith(color: AppColors.grey),
                                    maxLines: 4,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                buildTitle('Diễn viên'),
                                CastBar(size: size, movie: widget.movie),
                                buildTitle('Trailer'),
                                TrailerBar(size: size, movie: widget.movie),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: const Text('Đánh giá'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const FaIcon(FontAwesomeIcons.arrowLeft),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Padding buildTitle(String content) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        content,
        style: AppTextStyles.heading20,
      ),
    );
  }
}

String getGenresAsSingleString(Movie movie, List<Genre> genres) {
  String result = "";
  if (movie.genres.isNotEmpty) {
    for (int i = 0; i < movie.genres.length; i++) {
      if (i == 0) {
        result += getGenreDisplayName(movie.genres[i], genres);
      } else {
        result = "$result, ${getGenreDisplayName(movie.genres[i], genres)}";
      }
    }
  }
  return result;
}

String getGenreDisplayName(String id, List<Genre> genres) {
  for (Genre genre in genres) {
    if (genre.id == id) {
      return genre.displayName;
    }
  }
  return "";
}
