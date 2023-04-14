// ignore_for_file: unused_local_variable

import 'package:final_project/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> registerWithEmailAndPassword(
      String email, String password, String fullName) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _auth.currentUser?.updateDisplayName(fullName);
      toast('Tạo tài khoản thành công');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          toast('Tài khoản đã tồn tại');
          break;
        case 'weak-password':
          toast('Mật khẩu tối thiểu 6 ký tự');
      }
    }
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
