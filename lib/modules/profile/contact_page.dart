import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/constants/asset_path.dart';
import 'package:final_project/models/test_models.dart';
import 'package:final_project/modules/profile/components/header_with_searchbox.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Contact us',
          style: AppTextStyles.heading28,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.blueMain,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWithSearchBox(size: size),
            Center(
              child: Text(
                'Thành viên',
                style: AppTextStyles.heading20
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
              child: Column(
                children: members
                    .map((member) => Builder(
                          builder: (context) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member.memberName,
                                  style: AppTextStyles.heading18,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text('MSSV: ${member.studentId}',
                                      style: AppTextStyles.heading18
                                          .copyWith(color: AppColors.green)),
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 32),
                    alignment: Alignment.center,
                    width: size.width / 3,
                    height: size.width / 3,
                    decoration: BoxDecoration(
                        color: AppColors.blueMain,
                        borderRadius: BorderRadius.circular(size.width / 6)),
                    child: Image.asset(
                      AssetPath.iconLogo,
                      scale: 0.7,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Version: 1.0.0'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        FontAwesomeIcons.copyright,
                        color: AppColors.white,
                        size: 14,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text('Copyritght by group-19'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
