import 'package:final_project/models/test_models.dart';
import 'package:final_project/modules/movieDetail/components/caster_item.dart';
import 'package:flutter/material.dart';

class CastBar extends StatelessWidget {
  final TestMovie movie;
  const CastBar({
    super.key,
    required this.size,
    required this.movie,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.width / 3.5,
      child: CasterItem(
        size: size,
        movie: movie,
      ),
    );
  }
}
