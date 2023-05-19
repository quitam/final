// ignore_for_file: unused_local_variable, avoid_print

import 'package:final_project/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> validateOldPassword(String email, String password) async {
    var user = _auth.currentUser;
    var authCredentials =
        EmailAuthProvider.credential(email: email, password: password);
    try {
      var authResult =
          await user?.reauthenticateWithCredential(authCredentials);
      return authResult?.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updatePassword(String password) async {
    var user = _auth.currentUser;
    await user?.updatePassword(password);
  }

  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? user = await _googleSignIn.signIn();
    GoogleSignInAuthentication gAuth = await user!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    await _auth.signInWithCredential(credential);
    await _auth.currentUser?.reload();
    toast('Đăng nhập thành công');
  }

  Future<void> registerWithEmailAndPassword(String email, String password,
      String fullName, String urlDownload) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await _auth.currentUser?.updateDisplayName(fullName);
      await _auth.currentUser?.updatePhotoURL(urlDownload);
      _auth.signOut();
      toast('Tạo tài khoản thành công');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          toast('Tài khoản đã tồn tại');
          break;
        case 'weak-password':
          toast('Mật khẩu tối thiểu 6 ký tự');
          break;
        case 'invalid-email':
          toast('Email không đúng định dạng');
          break;
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
      } else if (e.code == 'invalid-email') {
        toast('Email không đúng định dạng');
      }
    }
  }
}
