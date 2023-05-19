// ignore_for_file: avoid_print

import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/constants/asset_path.dart';
import 'package:final_project/modules/admin/admin_page.dart';
import 'package:final_project/services/auth.dart';
import 'package:final_project/modules/auth/components/border_button.dart';
import 'package:final_project/modules/auth/components/logo.dart';
import 'package:final_project/modules/auth/register_page.dart';
import 'package:final_project/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  String _username = '';
  String _password = '';

  handleLogin() async {
    setState(() {
      loading = true;
    });
    if (_username == 'admin' && _password == 'admin') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AdminPage()),
          (route) => false);
    } else {
      await Auth().signInWithEmailAndPassword(_username, _password);
      if (FirebaseAuth.instance.currentUser != null) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
    setState(() {
      loading = false;
    });
  }

  googleLogin() async {
    setState(() {
      loading = true;
    });
    await Auth().signInWithGoogle();
    if (FirebaseAuth.instance.currentUser != null) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const FaIcon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Hero(tag: 'logo', child: Logo(boxSize: size.height / 9)),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Welcome back,\nMovie Lover!',
                      style: AppTextStyles.heading20,
                    ),
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  height: size.height * 0.05,
                  width: size.height * 0.05,
                  child: loading
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator())
                      : null,
                ),
              ),
              const Center(
                child: Hero(
                  tag: 'login',
                  child: Text(
                    'Đăng nhập',
                    style: AppTextStyles.heading32Bold,
                  ),
                ),
              ),

              //username
              buildUsernameField(),

              //password
              buildPasswordField(),

              //button login
              Center(
                child: BorderButton(
                    size: size,
                    onTap: () => handleLogin(),
                    text: 'Đăng nhập',
                    backgroundColor: (_username != '' && _password != '')
                        ? AppColors.blueMain
                        : AppColors.darkBackground,
                    borderColor: (_username != '' && _password != '')
                        ? AppColors.blueMain
                        : AppColors.darkBackground),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Nếu bạn chưa có tài khoản?',
                    style: AppTextStyles.heading18,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ));
                      },
                      child: Text(
                        'Đăng ký',
                        style: AppTextStyles.heading18.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.lightBlue),
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => googleLogin(),
                      child: Image.asset(
                        AssetPath.googleButton,
                        scale: 1.1,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('login with facebook');
                        toast('Cooming soon');
                      },
                      child: Image.asset(
                        AssetPath.facebookButton,
                        scale: 1.1,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildUsernameField() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          _username = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: AppTextStyles.heading18.copyWith(color: AppColors.grey),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.blueMain)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.white)),
      ),
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          _password = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Mật khẩu',
        labelStyle: AppTextStyles.heading18.copyWith(color: AppColors.grey),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.blueMain)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.white)),
      ),
    );
  }
}
