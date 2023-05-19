import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/modules/movieDetail/components/comment.dart';
import 'package:final_project/modules/movieDetail/components/fa_button.dart';
import 'package:final_project/modules/movieDetail/components/background_widget.dart';
import 'package:final_project/modules/movieDetail/components/cast_bar.dart';
import 'package:final_project/modules/movieDetail/components/trailer_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  List<Comment> comments = [];
  List<String> uniqueUserId = [];
  List<User?> users = [];
  TextEditingController commentController = TextEditingController();
  bool displayPaymentButton = false;


  User? getCommentUser(Comment comment) {
    for (User? tempUser in users) {
      if (tempUser!.uid == comment.userId) {
        return tempUser;
      }
    }
  }

  void getUniqueUserId() {
    for (Comment tempComment in comments) {
      if (!uniqueUserId.contains(tempComment.userId)) {
        uniqueUserId.add(tempComment.userId);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if(widget.isPlaying) displayPaymentButton = true;
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        
      });
    },);
    getCommentsOfMovie(widget.movie.id).then(
      (value) => {
        setState(
          () {
            comments = value;
            getUniqueUserId();
            for (String userId in uniqueUserId) {
              getUserById(userId).then((value) {
                setState(() {
                  users.add(value);
                });
              });
            }
          },
        )
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(context),
      floatingActionButton:  (widget.isPlaying && _tabController.index == 0) ? FAButton(widget: widget) : null,
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
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(FirebaseAuth.instance.currentUser?.photoURL ?? ""),
                                            radius: 20,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: TextFormField(
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              controller: commentController,
                                              decoration: const InputDecoration(
                                                hintText: 'Nhập bình luận',
                                                hintStyle: TextStyle(color: Colors.white24)
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          IconButton(
                                            icon: Icon(Icons.send, color:Colors.white70),
                                            onPressed:() {
                                              // addMovie(
                                              //     "mat_na_quy", 
                                              //     "Mặt Nạ Quỷ", 
                                              //     62, 
                                              //     "https://youtu.be/3MKRzG9k76Q", 
                                              //     ["horror", "thriller"],
                                              //     "Bí ẩn về cái chết của em gái Evie 20 năm trước còn bỏ ngỏ, vào lúc 09:09 hằng đêm, hàng loạt cuộc chạm trán kinh hoàng xảy ra. Liệu Margot có biết được sự thật ai là kẻ giết em gái mình?"
                                              //   );
                                              if(commentController.text.isNotEmpty)
                                              {
                                                addNewComment(widget.movie.id, commentController.text);
                                                commentController.clear();
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: comments.length,
                                      itemBuilder: (context, index) {
                                        return CommentWidget(
                                            comment: comments[index]);
                                      },
                                    ),
                                  ],
                                ))
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

bool addNewComment(String movieId, String content) {
  DocumentReference commentDoc =
      FirebaseFirestore.instance.collection("Comment").doc();
  Map<String, dynamic> comment = {
    'user': FirebaseAuth.instance.currentUser?.uid,
    'movie': movieId,
    'content': content,
    'user_name': FirebaseAuth.instance.currentUser?.displayName
  };
  bool result = true;
  commentDoc.set(comment).then((value) {}).catchError((error) {
    result = false;
    print("Khong the them document cho comment voi loi: $error");
  });
  return result;
}

bool addMovie(String id, String name, int duration, String trailer, List<String> genres, String synopsis){
   DocumentReference commentDoc =
      FirebaseFirestore.instance.collection("Movie").doc(id);
  Map<String, dynamic> comment = {
    "id": id,
    "poster_image": "posters/" + id + "_poster.png",
    "banner_image": "banners/" + id + "_banner.png",
    "name": name,
    "duration": duration,
    "trailer": trailer,
    "release_date": Timestamp.fromDate(DateTime.now()),
    "genres": List<dynamic>.from(genres), 
    "synopsis": synopsis
  };
  bool result = true;
  commentDoc.set(comment).then((value) {}).catchError((error) {
    result = false;
    print("Khong the them document cho comment voi loi: $error");
  });
  return result;
}