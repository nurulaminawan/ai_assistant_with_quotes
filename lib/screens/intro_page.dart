import 'package:ai_assistant_with_quotes/screens/category_screen.dart';
import 'package:ai_assistant_with_quotes/utils/app_colors.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List<String> titles = [
    'Now input Anything\nand\ngenerate your answers',
    'Get nice written articles\nwithin seconds',
    'AI based\n generated quotes'
  ];

  void initState() {
    super.initState();
  }

  Widget swipe() {
    return SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Swiper(
          itemBuilder: (context, index) {
            final texts = titles[index];
            return Center(
              child: Text(
                texts,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.textColorWhite,
                  fontWeight: FontWeight.normal,
                ),
              ),
            );
          },
          indicatorLayout: PageIndicatorLayout.COLOR,
          autoplay: false,
          itemCount: 3,
          pagination: const SwiperPagination(),
          viewportFraction: 0.8,
          scale: 0.9,
        ));
  }

  Widget intro() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 90),
        const Text(
          'Welcome to',
          style: TextStyle(
            fontSize: 32,
            color: AppColors.textColorWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'My AI Assistant',
          style: TextStyle(
            fontSize: 24,
            color: AppColors.textColorWhite,
          ),
        ),
        swipe(),
        const SizedBox(
          height: 50,
        ),
        Container(
            decoration: BoxDecoration(
              color: AppColors.textColorWhite,
              borderRadius: BorderRadius.circular(15),
            ),
            width: MediaQuery.of(context).size.width / 1.5,
            height: 75.0,
            child: Material(
              color: AppColors.tranparentColor,
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryScreen()));
                },
                borderRadius: BorderRadius.circular(15.0),
                splashColor: Colors.grey[500],
                child: const Center(
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.greenColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.topLeft,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.greenColor,
                  AppColors.purpleColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 100,
                left: 10,
                right: 10,
                bottom: 25,
              ),
              child: intro(),
            )));
  }
}
