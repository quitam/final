import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/modules/home/components/category_bar.dart';
import 'package:final_project/modules/home/components/current_playing.dart';
import 'package:final_project/modules/home/components/header.dart';
import 'package:final_project/modules/home/components/search_bar.dart';
import 'package:final_project/modules/home/components/up_coming.dart';
import 'package:final_project/modules/movieFilter/movie_filter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

typedef ShowMoreCallBack = void Function(BuildContext);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> allMovies = [];

  void handleShowMoreCurrentPlaying(BuildContext context) {
    List<Movie> playingMovies = [];
    for (Movie tempMovie in allMovies) {
      if (tempMovie.releaseDate.isBefore(DateTime.now())) {
        playingMovies.add(tempMovie);
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MovieFilter(
                stringToSearch: "đang được chiếu",
                movies: playingMovies,
              )),
    );
  }

  void handleShowMoreUpComing(BuildContext context) {
    List<Movie> playingMovies = [];
    for (Movie tempMovie in allMovies) {
      if (tempMovie.releaseDate.isAfter(DateTime.now())) {
        playingMovies.add(tempMovie);
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MovieFilter(
                stringToSearch: "sắp được chiếu",
                movies: playingMovies,
              )),
    );
  }

  @override
  void initState() {
    super.initState();
    getAllMovies().then((value) {
      setState(() {
        allMovies = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print(FirebaseAuth.instance.currentUser!.uid);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                HomeHeader(size: size),
                SearchBar(size: size),
                const CategoryBar(),
                buildTitle('Đang chiếu', handleShowMoreCurrentPlaying),
                PlayingMoviesSlider(size: size),
                buildTitle('Sắp chiếu', handleShowMoreUpComing),
                UpComing(size: size),
              ],
            )),
      ),
    );
  }

  Padding buildTitle(String title, ShowMoreCallBack showMoreCallback) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: AppTextStyles.heading20
                  .copyWith(fontWeight: FontWeight.w600)),
          ShowMoreButton(onPressed: showMoreCallback)
        ],
      ),
    );
  }
}

class ShowMoreButton extends StatelessWidget {
  final ShowMoreCallBack onPressed;
  const ShowMoreButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120, // Set your desired width
      height: 40, // Set your desired height
      child: TextButton(
        onPressed: () {
          onPressed(context);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.black,
                width: 0.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: const Text('Hiển thị thêm', style: AppTextStyles.hint15),
      ),
    );
  }
}
