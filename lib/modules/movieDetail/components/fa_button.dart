import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/modules/movieDetail/movie_detail_page.dart';
import 'package:final_project/modules/selectCinema/select_cinema_page.dart';
import 'package:flutter/material.dart';

class FAButton extends StatelessWidget {
  const FAButton({
    super.key,
    required this.widget,
  });

  final MovieDetailPage widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectCinemaPage(movie: widget.movie),
                ));
          },
          label: const Text(
            'Đặt vé ngay',
            style: AppTextStyles.heading18,
          )),
    );
  }
}
