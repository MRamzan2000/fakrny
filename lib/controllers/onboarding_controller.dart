import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController{

  // PageView controller
  final PageController pageController=PageController();

  // Current Page
  var currentPage=0.obs;
  //change page
  void nextPage() {
    if (currentPage.value < 3) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  // Update current page index on scroll
  void onPageChanged(int index) {
    currentPage.value = index;
  }

}