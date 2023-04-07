import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/models/test_models.dart';
import 'package:final_project/modules/movieDetail/components/background_widget.dart';
import 'package:final_project/modules/movieDetail/components/cast_bar.dart';
import 'package:final_project/modules/movieDetail/components/trailer_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailPage({super.key, required this.movie});

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
                    Hero(
                      tag: widget.movie.id,
                      child: SizedBox(
                        width: size.width / 2.5,
                        child: Image.asset(
                          widget.movie.poster,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
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
                              margin: const EdgeInsets.only(left: 8, bottom: 8),
                              child: Row(
                                children: const [Text('5000 votes')],
                              )),
                          Container(
                            padding: const EdgeInsets.only(left: 8, bottom: 8),
                            width: size.width,
                            child: Text(
                              widget.movie.genre,
                              style: AppTextStyles.normal16
                                  .copyWith(color: AppColors.green),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 8, bottom: 8),
                            width: size.width,
                            child: Text('Duration: ${widget.movie.duration}min',
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
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    alignment: Alignment.center,
                    width: size.width,
                    child: TabBar(
                      tabs: const [
                        Tab(
                          text: 'Abbout Movie',
                        ),
                        Tab(
                          text: 'Review',
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
                  Expanded(
                      child: TabBarView(
                    controller: _tabController,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          buildTitle('Synopsis'),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              '   ${widget.movie.synopsis}',
                              style: AppTextStyles.normal16
                                  .copyWith(color: AppColors.grey),
                            ),
                          ),
                          buildTitle('Cast and Crew'),
                          CastBar(
                            size: size,
                            movie: widget.movie,
                          ),
                          buildTitle('Trailer and song'),
                          TrailerBar(size: size)
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text('Review Tab'),
                      )
                    ],
                  ))
                ]),
              )
            ],
          ),
        ],
      )),
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
