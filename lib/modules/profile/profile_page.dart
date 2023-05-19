import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/constants/asset_path.dart';
import 'package:final_project/modules/auth/components/border_button.dart';
import 'package:final_project/modules/auth/loading_page.dart';
import 'package:final_project/modules/profile/change_password_page.dart';
import 'package:final_project/modules/profile/contact_page.dart';
import 'package:final_project/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser?.reload();
    final Size size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    String platform =
        FirebaseAuth.instance.currentUser!.providerData[0].providerId;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (platform == 'google.com')
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      AssetPath.googleButton,
                      scale: 2,
                    ),
                  ),
                Text(
                  user.displayName.toString(),
                  style: AppTextStyles.heading20,
                ),
              ],
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
              child: GestureDetector(
                onTap: () {
                  if (platform == 'google.com') {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        backgroundColor: AppColors.darkGrey,
                        title: Text(
                          'Thông báo',
                          style: AppTextStyles.heading20
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        content: const Text(
                            'Bạn không thể đổi mật khẩu khi đăng nhập bằng Google',
                            style: AppTextStyles.heading18),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text(
                              'OK',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (platform == 'password') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChangePasswordPage(email: user.email.toString()),
                        ));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  alignment: Alignment.centerLeft,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: AppColors.white, width: 2))),
                  child: RichText(
                      text: TextSpan(
                          style: AppTextStyles.heading18.copyWith(
                              color: platform == 'password'
                                  ? AppColors.white
                                  : AppColors.grey),
                          children: [
                        WidgetSpan(
                            child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FaIcon(
                            FontAwesomeIcons.penToSquare,
                            color: platform == 'password'
                                ? AppColors.blueMain
                                : AppColors.grey,
                          ),
                        )),
                        const TextSpan(text: 'Đổi mật khẩu'),
                      ])),
                ),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ContactPage(),
                      ));
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
                  // onTap: () {
                  //   FirebaseAuth.instance.signOut();
                  //   googleSignIn.signOut();

                  //   Navigator.of(context).pushAndRemoveUntil(
                  //       MaterialPageRoute(
                  //           builder: (context) => const LoadingPage()),
                  //       (route) => false);
                  //   toast('Đăng xuất thành công');
                  // },
                  onTap: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          backgroundColor: AppColors.darkGrey,
                          title: Text(
                            'Đăng xuất',
                            style: AppTextStyles.heading20
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          content: const Text(
                              'Bạn có chắc muốn đăng xuất khỏi ứng dụng?',
                              style: AppTextStyles.heading18),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Hủy'),
                              child: const Text(
                                'Hủy',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                googleSignIn.signOut();

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoadingPage()),
                                    (route) => false);
                                toast('Đăng xuất thành công');
                              },
                              child: const Text('Đăng xuất'),
                            ),
                          ],
                        ),
                      ),
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
