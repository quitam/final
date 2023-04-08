import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/constants/asset_path.dart';
import 'package:final_project/models/test_models.dart';
import 'package:final_project/modules/checkOut/check_out_page.dart';
import 'package:final_project/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectSeatPage extends StatelessWidget {
  const SelectSeatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Movie title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: const Text(
                  'Ralph Breaks the Internet',
                  style: AppTextStyles.heading20,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  'Lotteria',
                  style: AppTextStyles.heading18.copyWith(
                      fontStyle: FontStyle.italic, color: AppColors.grey),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSeatStatus(
                    color: AppColors.darkBackground, status: 'Available'),
                buildSeatStatus(
                    color: AppColors.blueMain, status: 'Your choice'),
                buildSeatStatus(
                    color: AppColors.greyBackground, status: 'Booked'),
              ],
            ),
          ),

          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: seatRow
                  .map((row) => Builder(
                        builder: (context) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: seatNumber
                              .map((number) => Builder(
                                    builder: (context) => SizedBox(
                                      height: 44,
                                      width: 44,
                                      child: GestureDetector(
                                        onTap: () {
                                          toast(
                                              'Select $row${number.toString()}');
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              color: AppColors.darkBackground),
                                          child: Text(row + number.toString()),
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ))
                  .toList(),
            ),
          )),

          Container(
            alignment: Alignment.center,
            child: Text(
              'Screen',
              style: AppTextStyles.heading18.copyWith(color: AppColors.grey),
            ),
          ),
          Center(child: Image.asset(AssetPath.screen)),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total price:',
                      style: AppTextStyles.normal16
                          .copyWith(color: AppColors.green),
                    ),
                    const Text(
                      '79.000 VND',
                      style: AppTextStyles.heading18,
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // ignore: avoid_print
                    print('Check out');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckOutPage(),
                        ));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: size.height / 16,
                    width: size.width / 3,
                    decoration: BoxDecoration(
                        color: AppColors.blueMain,
                        borderRadius: BorderRadius.circular(16)),
                    child: const Text(
                      'Check out',
                      style: AppTextStyles.heading20,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  Row buildSeatStatus({required String status, required Color color}) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            status,
            style: AppTextStyles.heading18,
          ),
        ),
      ],
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
