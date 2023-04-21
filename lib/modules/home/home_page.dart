import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/modules/home/components/category_bar.dart';
import 'package:final_project/modules/home/components/current_playing.dart';
import 'package:final_project/modules/home/components/header.dart';
import 'package:final_project/modules/home/components/search_bar.dart';
import 'package:final_project/modules/home/components/up_coming.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                //header
                HomeHeader(size: size),
                Text(user!.email.toString()),
                //search bar
                SearchBar(size: size),
                //category bar
                const CategoryBar(),
                buildTitle('Đang chiếu'),
                PlayingMoviesSlider(size: size),
                buildTitle('Sắp chiếu'),
                UpComing(size: size),
              ],
            )),
      ),
    );
  }

  Padding buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          Text(title,
              style: AppTextStyles.heading20
                  .copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
