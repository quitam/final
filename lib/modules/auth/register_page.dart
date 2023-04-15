import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/services/auth.dart';
import 'package:final_project/modules/auth/components/border_button.dart';
import 'package:final_project/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool loading = false;
  String _fullName = '';
  String _username = '';
  String _password = '';
  String _confirmPassword = '';

  handleSignup() async {
    if (_fullName.length >= 6) {
      if (_username.length >= 10) {
        if (_password == _confirmPassword) {
          setState(() {
            loading = true;
          });
          await Auth()
              .registerWithEmailAndPassword(_username, _password, _fullName);
          if (FirebaseAuth.instance.currentUser != null) {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }
          setState(() {
            loading = false;
          });
        } else {
          toast('Mật khẩu không khớp');
        }
      } else {
        toast('Email không đúng định dạng');
      }
    } else {
      toast('Họ tên không hợp lệ');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
            Center(
              child: SizedBox(
                height: size.height * 0.1,
                width: size.height * 0.1,
                child: loading
                    ? const Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator())
                    : null,
              ),
            ),
            const Center(
              child: Hero(
                tag: 'signup',
                child: Text(
                  'Đăng ký',
                  style: AppTextStyles.heading32Bold,
                ),
              ),
            ),
            //fullname
            buildFullNameField(),

            //username
            buildUsernameField(),

            //password
            buildPasswordField(),

            //confirm password
            buildConfirmPasswordField(),

            //button login
            Center(
              child: BorderButton(
                  size: size,
                  onTap: () => handleSignup(),
                  text: 'Đăng ký',
                  backgroundColor: (_username != '' &&
                          _password != '' &&
                          _fullName != '' &&
                          _confirmPassword != '')
                      ? AppColors.blueMain
                      : AppColors.darkBackground,
                  borderColor: (_username != '' &&
                          _password != '' &&
                          _fullName != '' &&
                          _confirmPassword != '')
                      ? AppColors.blueMain
                      : AppColors.darkBackground),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildFullNameField() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          _fullName = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Họ tên',
        labelStyle: AppTextStyles.heading18.copyWith(color: AppColors.grey),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.blueMain)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: _fullName.length >= 6 ? Colors.green : Colors.red)),
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
            borderSide: BorderSide(
                color: _username.length > 10 ? Colors.green : Colors.red)),
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
            borderSide: BorderSide(
                color: _password.length >= 6 ? Colors.green : Colors.red)),
      ),
    );
  }

  TextFormField buildConfirmPasswordField() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          _confirmPassword = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Nhập lại mật khẩu',
        labelStyle: AppTextStyles.heading18.copyWith(color: AppColors.grey),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: (_confirmPassword.length >= 6 &&
                        _confirmPassword == _password)
                    ? Colors.green
                    : Colors.red)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: (_confirmPassword.length >= 6 &&
                        _confirmPassword == _password)
                    ? Colors.green
                    : Colors.red)),
      ),
    );
  }
}
