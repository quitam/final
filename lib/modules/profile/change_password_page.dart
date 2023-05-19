// ignore_for_file: use_build_context_synchronously

import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/modules/auth/components/border_button.dart';
import 'package:final_project/modules/auth/loading_page.dart';
import 'package:final_project/services/auth.dart';
import 'package:final_project/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ChangePasswordPage extends StatefulWidget {
  final String email;
  const ChangePasswordPage({super.key, required this.email});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool loading = false;
  String _oldPassword = '';
  String _newPassword = '';
  String _confirm = '';
  final GoogleSignIn googleSignIn = GoogleSignIn();
  handleChangePass() async {
    setState(() {
      loading = true;
    });
    var result = await Auth().validateOldPassword(widget.email, _oldPassword);
    if (result) {
      if (_newPassword != '') {
        if (_confirm == _newPassword) {
          await Auth().updatePassword(_newPassword);
          FirebaseAuth.instance.signOut();
          googleSignIn.signOut();

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoadingPage()),
              (route) => false);
          toast('Đổi mật khẩu thành công, vui lòng đăng nhập lại');
        } else {
          toast('Mật khẩu không khớp, vui lòng kiểm tra lại');
        }
      } else {
        toast('Vui lòng nhập mật khẩu mới');
      }
    } else {
      toast('Mật khẩu cũ không đúng');
    }
    setState(() {
      loading = false;
    });
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
        title: const Text(
          'Đổi mật khẩu',
          style: AppTextStyles.heading28,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
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

            // old password
            buildOldPasswordField(),

            // new password
            buildNewPasswordField(),

            // old password
            buildConfirmField(),

            //button login
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BorderButton(
                    size: size,
                    onTap: () => handleChangePass(),
                    text: 'Cập nhật',
                    backgroundColor: (_confirm == _newPassword &&
                            _oldPassword != '' &&
                            _newPassword != '')
                        ? AppColors.blueMain
                        : AppColors.darkBackground,
                    borderColor: (_confirm == _newPassword &&
                            _oldPassword != '' &&
                            _newPassword != '')
                        ? AppColors.blueMain
                        : AppColors.darkBackground),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildOldPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            _oldPassword = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Mật khẩu cũ',
          labelStyle: AppTextStyles.heading18.copyWith(color: AppColors.grey),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.blueMain)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.white)),
        ),
      ),
    );
  }

  Padding buildNewPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            _newPassword = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Mật khẩu mới',
          labelStyle: AppTextStyles.heading18.copyWith(color: AppColors.grey),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.blueMain)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.white)),
        ),
      ),
    );
  }

  Padding buildConfirmField() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        onChanged: (value) {
          setState(() {
            _confirm = value;
          });
        },
        decoration: InputDecoration(
          labelText: 'Nhập lại mật khẩu',
          labelStyle: AppTextStyles.heading18.copyWith(color: AppColors.grey),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.blueMain)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.white)),
        ),
      ),
    );
  }
}
