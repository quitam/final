import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/modules/auth/components/border_button.dart';
import 'package:final_project/modules/auth/loading_page.dart';
import 'package:final_project/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser?.reload();
    final Size size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(28),
              child: CircleAvatar(
                  radius: size.height / 15,
                  backgroundImage: NetworkImage(user!.photoURL.toString())),
            ),
            Text(
              user.displayName.toString(),
              style: AppTextStyles.heading20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                user.email.toString(),
                style: AppTextStyles.heading18.copyWith(color: AppColors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: AppColors.white, width: 2))),
                child: RichText(
                    text: const TextSpan(
                        style: AppTextStyles.heading18,
                        children: [
                      WidgetSpan(
                          child: Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: FaIcon(
                          FontAwesomeIcons.penToSquare,
                          color: AppColors.blueMain,
                        ),
                      )),
                      TextSpan(text: 'Cập nhật thông tin'),
                    ])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  toast('Coming soon');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: AppColors.white, width: 2))),
                  child: RichText(
                      text: const TextSpan(
                          style: AppTextStyles.heading18,
                          children: [
                        WidgetSpan(
                            child: Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: FaIcon(
                            FontAwesomeIcons.question,
                            color: AppColors.blueMain,
                          ),
                        )),
                        TextSpan(text: 'Câu hỏi thường gặp'),
                      ])),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  toast('Gọi 0813 931 040');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: AppColors.white, width: 2))),
                  child: RichText(
                      text: const TextSpan(
                          style: AppTextStyles.heading18,
                          children: [
                        WidgetSpan(
                            child: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: FaIcon(
                            FontAwesomeIcons.phone,
                            color: AppColors.blueMain,
                          ),
                        )),
                        TextSpan(text: 'Liên hệ với chúng tôi'),
                      ])),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: BorderButton(
                  size: size,
                  onTap: () {
                    FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoadingPage()),
                        (route) => false);
                    toast('Đăng xuất thành công');
                  },
                  text: 'Đăng xuất',
                  backgroundColor: AppColors.blueMain,
                  borderColor: AppColors.blueMain),
            )
          ],
        ),
      ),
    );
  }
}
