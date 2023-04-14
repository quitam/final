import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/modules/auth/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      // home: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.userChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return const MyHomePage();
      //     } else {
      //       return const WelcomePage();
      //     }
      //   },
      // ),
      home: const LoadingPage(),
    );
  }
}
