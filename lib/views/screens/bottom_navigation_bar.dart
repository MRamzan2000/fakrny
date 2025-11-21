import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.white,
        color: AppColors.primaryColor,
        items: [
          CurvedNavigationBarItem(
            child: SvgPicture.asset("assets/icons/home.svg",
            color: AppColors.white,),
            label: 'Home',
              labelStyle: TextStyle(
                  color: AppColors.white
              )
          ),
          CurvedNavigationBarItem(
            child:  SvgPicture.asset("assets/icons/meds.svg",
              color: AppColors.white,),
            label: 'My Meds',
              labelStyle: TextStyle(
                  color: AppColors.white
              )
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset("assets/icons/statistics.svg",
              color: AppColors.white,),
            label: 'Statistics',
              labelStyle: TextStyle(
                  color: AppColors.white
              )
          ),
          CurvedNavigationBarItem(
            child:SvgPicture.asset("assets/icons/history.svg",
              color: AppColors.white,),
            label: 'History ',
            labelStyle: TextStyle(
              color: AppColors.white
            )
          ),
        ],
        onTap: (index) {
          // Handle button tap
        },
      ),
      body: Container(color: AppColors.white),
    );
  }
}
