import 'package:final_project/config/themes/app_colors.dart';
import 'package:final_project/config/themes/app_text_styles.dart';
import 'package:final_project/modules/profile/profile_page.dart';
import 'package:final_project/modules/home/home_page.dart';
import 'package:final_project/modules/ticket/ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  final screens = [const MyHomePage(), const TicketPage(), const ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.darkBackground,
          selectedItemColor: AppColors.blueMain,
          selectedLabelStyle: AppTextStyles.heading18.copyWith(fontSize: 16),
          showUnselectedLabels: false,
          unselectedItemColor: AppColors.grey,
          iconSize: 32,
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
                currentIndex = index;
              }),
          items: const [
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house), label: 'Home'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.ticket), label: 'Ticket'),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user), label: 'Profile')
          ]),
    );
  }
}
