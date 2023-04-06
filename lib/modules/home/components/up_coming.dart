import 'package:final_project/models/test_models.dart';
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      height: size.width / 2.5,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(
                        movie: movies[index],
                      ),
                    ));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(movies[index].poster),
                        fit: BoxFit.cover)),
              ),
            );
          }),
    );
  }
}
