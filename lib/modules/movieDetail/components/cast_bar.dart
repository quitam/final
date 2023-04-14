import 'package:final_project/funtion_library.dart';
import 'package:final_project/models/models.dart';
import 'package:final_project/modules/movieDetail/components/caster_item.dart';
import 'package:flutter/material.dart';

class CastBar extends StatelessWidget {
  final Movie movie;
  const CastBar({
    super.key,
    required this.size,
    required this.movie,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   height: size.width / 3.5,
    //   child: CasterItem(
    //     size: size,
    //     movie: testMovie,
    //   ),
    // );
    return SizedBox(
      height: size.width / 3.5,
      child: FutureBuilder(
        future: getActorOfMovie(movie.id),
        builder: ((context, snapshot) {
          if (!snapshot.hasError && snapshot.hasData) {
            List<Actor> actors = snapshot.data!;
            return CasterItem(size: size, actors: actors);
          } else {
            return const SizedBox(height: 0, width: 0);
          }
        }),
      ),
    );
  }
}
