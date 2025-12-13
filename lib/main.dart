import 'dart:io';
import 'package:fakrny/controllers/user_controller.dart';
import 'package:fakrny/utils/app_colors.dart';
import 'package:fakrny/utils/app_translations.dart';
import 'package:fakrny/utils/my_shared_pref.dart';
import 'package:fakrny/views/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'controllers/auth_controller.dart';
import 'controllers/medicine_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  final firebaseOptions = FirebaseOptions(
    apiKey: Platform.isAndroid
        ? 'AIzaSyD95x9NDrduxVVPex_vPBJo4i6yGYvz2_8'
        : 'AIzaSyCqvHxHdt8yVuWwP5jXPkJkXaiMFr1-6cI',
    appId: Platform.isAndroid
        ? '1:1009934192640:android:af7430ccb69847109548e5'
        : '1:1009934192640:ios:c0d875ceed6098139548e5',
    messagingSenderId: '1009934192640',
    projectId: 'fakrny-8537b',
  );
  await Firebase.initializeApp(options: firebaseOptions);
  Get.put(AuthController());
  Get.put(UserController());
  Get.put(MedicineController());
  await SharedPrefHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final savedLocale = SharedPrefHelper.getSavedLanguage();
    return ResponsiveSizer(
      builder: (context, orientation, screenType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ar', 'SA'),
        ],
        translations: AppTranslations(),
        locale: savedLocale,
        fallbackLocale: const Locale('en', 'US'),
        builder: (context, child) {
          return Directionality(
            textDirection: Get.locale?.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            child: child!,
          );
        },

        title: "app_name".tr,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
          fontFamily: "SfPro",
          useMaterial3: true,
        ),

        home: const SplashScreen(),
      ),
    );
  }
}