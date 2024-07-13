import 'dart:async';

import 'package:ai_assistant_with_quotes/screens/category_screen.dart';
import 'package:ai_assistant_with_quotes/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CategoryScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "MY PERSONALized\nCHATBOT\n&\nQUOTES".toUpperCase(),
                style: TextStyle(
                    color: AppColors.textColorWhite,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Center(
                child: SpinKitRing(
                  color: AppColors.textColorWhite,
                  size: 50.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Loading ...",
                style: TextStyle(
                  color: AppColors.textColorWhite,
                  fontWeight: FontWeight.w600, // light
                  fontStyle: FontStyle.normal, // italic
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
