// ignore_for_file: unused_local_variable

import 'package:final_project/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    final user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      toast('Đăng nhập thành công');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        toast('Tài khoản không tồn tại');
      } else if (e.code == 'wrong-password') {
        toast('Sai mật khẩu');
      }
    }
  }
}
