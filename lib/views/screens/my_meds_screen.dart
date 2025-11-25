import 'package:fakrny/utils/app_colors.dart';
import 'package:flutter/material.dart';

class MyMedsScreen extends StatelessWidget {
  const MyMedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(  mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("MyMeds Screen",style: TextStyle(color: AppColors.black),)

          ],),
      ),
    );
  }
}
