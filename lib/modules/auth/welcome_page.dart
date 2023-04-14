import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/modules/auth/components/border_button.dart';
import 'package:final_project/modules/auth/components/logo.dart';
import 'package:final_project/modules/auth/login_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Hero(tag: 'logo', child: Logo(boxSize: size.height / 8)),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: const Text(
                    'Welcome',
                    style: AppTextStyles.heading28,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                    'Watch a new movie much\n   easier than any before',
                    style: AppTextStyles.hint15,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Hero(
                  tag: 'login',
                  child: BorderButton(
                    size: size,
                    onTap: () {
                      // ignore: avoid_print
                      print('Login');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    },
                    text: 'Đăng nhập',
                    backgroundColor: AppColors.lightBlue,
                    borderColor: Colors.transparent,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BorderButton(
                  size: size,
                  onTap: () {
                    // ignore: avoid_print
                    print('Sign up');
                  },
                  text: 'Đăng ký',
                  backgroundColor: Colors.transparent,
                  borderColor: AppColors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
