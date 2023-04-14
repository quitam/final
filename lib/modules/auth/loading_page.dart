import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/modules/auth/components/logo.dart';
import 'package:final_project/modules/auth/welcome_page.dart';
import 'package:final_project/modules/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StreamBuilder<User?>(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const MyHomePage();
                } else {
                  return const WelcomePage();
                }
              },
            ),
          ));
    });
    return Scaffold(
        body: Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
          children: [
            Hero(tag: 'logo', child: Logo(boxSize: size.height / 8)),
            Container(
              margin: const EdgeInsets.only(top: 14),
              child: const Text(
                'Movie tickets',
                style: AppTextStyles.heading32Bold,
              ),
            )
          ],
        ),
        const CircularProgressIndicator()
      ]),
    ));
  }
}
