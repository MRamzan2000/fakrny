import 'dart:io';

import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/views/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase Initialization
  final firebaseOptions = FirebaseOptions(
    apiKey: Platform.isAndroid
        ? 'AIzaSyAhempqegwQedLVwhScQeQdIwM_OHLx-ME'
        : 'AIzaSyBjtAgCsrbCqG02tHe9upMM2BK5N_748_g',
    appId: Platform.isAndroid
        ? '1:206987515302:android:1c3164c1a80064e5ef2b67'
        : '1:206987515302:ios:d0c787504291a648ef2b67',
    messagingSenderId: '206987515302',
    projectId: 'fakrny-app-57294',
  );
  await Firebase.initializeApp(
    options: firebaseOptions
  );
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
              home: SplashScreen()),
    );
  }
}