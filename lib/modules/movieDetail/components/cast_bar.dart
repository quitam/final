import 'package:final_project/modules/movieDetail/components/caster_item.dart';
import 'package:flutter/material.dart';

class CastBar extends StatelessWidget {
  const CastBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.width / 3.5,
      child: CasterItem(size: size),
    );
  }
}
