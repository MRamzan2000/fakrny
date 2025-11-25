import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/views/home_screen.dart';
import 'package:fakrny/views/screens/history_screen.dart';
import 'package:fakrny/views/screens/my_meds_screen.dart';
import 'package:fakrny/views/screens/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final RxInt _selectedIndex = 0.obs;
   var screens=[
     HomeScreen(),
     MyMedsScreen(),
     StatisticsScreen(),
     HistoryScreen()
   ].obs;
  @override
  Widget build(BuildContext context) {
    final Color activeColor = AppColors.black;
    final Color inactiveColor = AppColors.white;

    return Obx(
      ()=> Scaffold(
        backgroundColor: AppColors.primaryColor,
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: AppColors.white,
          color: AppColors.primaryColor,
          index: _selectedIndex.value,
          onTap: (index) {
              _selectedIndex.value = index;
          },
          items: [
            CurvedNavigationBarItem(
              child: SvgPicture.asset(
                "assets/icons/home.svg",
                color: _selectedIndex.value == 0 ? activeColor : inactiveColor,
              ),
              label: 'Home',
              labelStyle: TextStyle(
                color: _selectedIndex.value == 0 ? activeColor : inactiveColor,
              ),
            ),
            CurvedNavigationBarItem(
              child: SvgPicture.asset(
                "assets/icons/meds.svg",
                color: _selectedIndex.value == 1 ? activeColor : inactiveColor,
              ),
              label: 'My Meds',
              labelStyle: TextStyle(
                color: _selectedIndex.value == 1 ? activeColor : inactiveColor,
              ),
            ),
            CurvedNavigationBarItem(
              child: SvgPicture.asset(
                "assets/icons/statistics.svg",
                color: _selectedIndex.value == 2 ? activeColor : inactiveColor,
              ),
              label: 'Statistics',
              labelStyle: TextStyle(
                color: _selectedIndex.value == 2 ? activeColor : inactiveColor,
              ),
            ),
            CurvedNavigationBarItem(
              child: SvgPicture.asset(
                "assets/icons/history.svg",
                color: _selectedIndex.value == 3 ? activeColor : inactiveColor,
              ),
              label: 'History',
              labelStyle: TextStyle(
                color: _selectedIndex.value == 3 ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
        body: screens[ _selectedIndex.value],
      ),
    );
  }
}