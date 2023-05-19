import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
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
        child: Column(
          children: [HeaderWithSearchBox(size: size), const Text('hihi')],
        ),
      ),
    );
  }
}
