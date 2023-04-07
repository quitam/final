import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/modules/selectCinema/components/date_bar.dart';
import 'package:final_project/modules/selectCinema/components/time_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectCinemaPage extends StatelessWidget {
  const SelectCinemaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: size.height / 10,
                  child: const Center(
                    child: Text(
                      'Ralph Breaks the\nInternet',
                      style: AppTextStyles.heading28,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                buildAppBar(context)
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
              height: size.height / 14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.white),
              ),
              child: Row(children: const [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Select Your Country',
                      hintStyle: AppTextStyles.heading20,
                      icon: Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Icon(
                          Icons.location_on,
                          color: AppColors.white,
                        ),
                      )),
                )),
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(
                    size: 32,
                    Icons.keyboard_arrow_down,
                    color: AppColors.white,
                  ),
                )
              ]),
            ),
            buildTitle('Choose date'),
            DateBar(size: size),
            buildTitle('Lotteria'),
            TimeBar(size: size),
            buildTitle('CGV'),
            TimeBar(size: size),
            buildTitle('BHD Star'),
            TimeBar(size: size),
            Container(
              margin: const EdgeInsets.only(top: 32),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBackground,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(18)),
                child: const Icon(
                  Icons.arrow_forward,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildTitle(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Text(
        title,
        style: AppTextStyles.heading20,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const FaIcon(FontAwesomeIcons.arrowLeft),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
