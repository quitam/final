import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/modules/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'montserrat',
          scaffoldBackgroundColor: AppColors.darkerBackground,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: AppColors.white, displayColor: AppColors.white)),
      home: const MyHomePage(),
    );
  }
}
