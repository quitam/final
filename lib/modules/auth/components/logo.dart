import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/constants/asset_path.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    required this.boxSize,
  });

  final double boxSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
          color: AppColors.blueMain, borderRadius: BorderRadius.circular(20)),
      child: Image.asset(AssetPath.iconLogo),
    );
  }
}
