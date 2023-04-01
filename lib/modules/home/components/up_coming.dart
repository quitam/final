import 'package:final_project/models/test_models.dart';
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
          itemCount: comings.length,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                alignment: Alignment.center,
                width: 120,
                child: Image.asset(
                  comings[index].imagePath,
                  fit: BoxFit.cover,
                ));
          }),
    );
  }
}
