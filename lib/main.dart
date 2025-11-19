import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/views/screens/on_boarding_screen.dart';
import 'package:fakrny/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (buildContext, orientation, screenType) =>
          GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  scaffoldBackgroundColor: AppColors.white
              ),
              home: OnBoardingScreen()),
    );
  }
}