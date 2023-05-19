import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/models/test_models.dart';
import 'package:final_project/modules/movieFilter/movie_filter.dart';

import 'package:flutter/material.dart';

class CategoryBar extends StatefulWidget {
  const CategoryBar({
    super.key,
  });

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  int selectedTab = 0;
  List<Movie> allMovies = [];

  @override
  void initState()
  {
    super.initState();
    getAllMovies().then((value){
      setState(() {
        allMovies = value;
      });
    });
  }

  List<Movie> getMoviesOfGenre(String genreId)
  {
    if(genreId == "all") return allMovies;
    List<Movie> qualifiedMovies = [];
    for(Movie tempMovie in allMovies)
    {
      if(!qualifiedMovies.contains(tempMovie) && tempMovie.genres.contains(genreId))
      {
        qualifiedMovies.add(tempMovie);
      }
    }
    return qualifiedMovies;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: StreamBuilder(
        stream: getGenres(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final genres = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: genres.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = index;
                    });
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieFilter(
                              stringToSearch: "thể loại " + genres[index].displayName,
                              movies: getMoviesOfGenre(genres[index].id)
                            )),
                  );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    alignment: Alignment.center,
                    width: 90,
                    decoration: selectedTab == index
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.lightBlue,
                          )
                        : const BoxDecoration(color: Colors.transparent),
                    child: Text(
                      genres[index].displayName,
                      style: AppTextStyles.normal15,
                    ),
                  ),
                );
              },
            );
          } else {
            return const Spacer();
          }
        },
      ),
    );
  }
}
