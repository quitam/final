import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/funtion_library.dart';
import 'package:final_project/modules/admin/add_movie.dart';
import 'package:final_project/modules/auth/loading_page.dart';
import 'package:final_project/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin',
          style: AppTextStyles.heading28,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddMovie(),
                      ));
                },
                child: const Text('Thêm phim')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: AppColors.darkGrey,
            title: Text(
              'Đăng xuất',
              style:
                  AppTextStyles.heading20.copyWith(fontWeight: FontWeight.bold),
            ),
            content: const Text('Bạn có chắc muốn đăng xuất quyền admin',
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
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoadingPage()),
                      (route) => false);
                  toast('Đăng xuất thành công');
                },
                child: const Text('Đăng xuất'),
              ),
            ],
          ),
        ),
        child: const Icon(FontAwesomeIcons.rightFromBracket),
      ),
    );
  }
}
