import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/constants/asset_path.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        height: size.height / 15,
        child: Row(children: [
          Expanded(
              child: Container(
            height: size.height / 15,
            decoration: BoxDecoration(
                color: AppColors.darkBackground,
                borderRadius: BorderRadius.circular(20)),
            child: Row(children: const [
              Padding(
                padding: EdgeInsets.only(left: 24, right: 12),
                child: FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: AppColors.white,
                ),
              ),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search movie...',
                  hintStyle: AppTextStyles.heading18,
                  border: InputBorder.none,
                ),
              ))
            ]),
          )),
          GestureDetector(
            onTap: () {
              // ignore: avoid_print
              print('click');
            },
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              alignment: Alignment.center,
              width: size.height / 15,
              height: size.height / 15,
              decoration: BoxDecoration(
                  color: AppColors.blueMain,
                  borderRadius: BorderRadius.circular(14)),
              child: const FaIcon(
                FontAwesomeIcons.sliders,
                color: AppColors.white,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
