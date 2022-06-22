import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trackhub_home_health/app/ui/pages/welcome.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:video_player/video_player.dart';


class IntroSlider extends StatefulWidget {
  const IntroSlider({Key? key}) : super(key: key);

  @override
  State<IntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  late final PageController _controller;
  late VideoPlayerController _videocontroller1, _videocontroller2, _videocontroller3;


  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
    _videocontroller1 = VideoPlayerController.asset(
        'assets/videos/intro1.mp4')..initialize().then((_) {
        setState(() {});
      });
    _videocontroller2 = VideoPlayerController.asset(
        'assets/videos/intro2.mp4')..initialize().then((_) {
      setState(() {});
    });
    _videocontroller3 = VideoPlayerController.asset(
        'assets/videos/intro3.mp4')..initialize().then((_) {
      setState(() {});
    });
    _videocontroller1.setLooping(false);
    _videocontroller2.setLooping(false);
    _videocontroller3.setLooping(false);
    _videocontroller1.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    _videocontroller1.dispose();
    _videocontroller2.dispose();
    _videocontroller3.dispose();
    super.dispose();
  }
  double videoContainerRatio = 0.5;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Welcome()));
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.appColor0),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: DeviceUtils.getScaledWidth(context, scale: 0.01)),
        child: PageView(
          scrollDirection: Axis.horizontal,
          onPageChanged: (val){
            val == 0 ? _videocontroller1.play() : val == 1 ? _videocontroller2.play() : _videocontroller3.play();
          },
          controller: _controller,
          children: <Widget>[
            Center(
              child: ScreenOne(context, _controller, _videocontroller1, _videocontroller2),
            ),
            Center(
              child: ScreenTwo(context, _controller, _videocontroller2, _videocontroller3),
            ),
            Center(
              child: ScreenThree(context, _controller, _videocontroller3),
            )
          ],
        ),
      ),
    );
  }
}

Widget ScreenOne(context, _controller, _videocontroller1, _videocontroller2) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.01),
      ),

      Image.asset(
        'assets/images/logo.png',
        width: DeviceUtils.getScaledWidth(context, scale: 0.6),
        height: DeviceUtils.getScaledHeight(context, scale: 0.1),
        fit: BoxFit.contain,
      ),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.02),
      ),
      Container(
        width: DeviceUtils.getScaledWidth(context, scale: 0.7),
        height: DeviceUtils.getScaledHeight(context, scale: 0.45),
        child: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _videocontroller1.value.size?.width ?? 0,
              height: _videocontroller1.value.size?.height ?? 0,
              child: VideoPlayer(_videocontroller1),
            ),
          ),
        ),
      ),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.02),
      ),
      const Spacer(),
      Container(
          width: DeviceUtils.getScaledWidth(context, scale: 0.4),
          height: 8,
          decoration: BoxDecoration(
              color: AppColors.color1, borderRadius: BorderRadius.circular(10)),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                constraints: BoxConstraints(
                    minWidth: 10,
                    maxWidth: DeviceUtils.getScaledWidth(context, scale: 0.4)),
                height: 10,
                width: DeviceUtils.getScaledWidth(context, scale: 0.4) / 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.appPrimaryColor),
                child: Text('')),
          )),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.07),
      ),
      const Text(
        'Easily carry out tests',
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            fontFamily: 'Montserrat ExtraBold',
            color: AppColors.appPrimaryColor),
      ),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.02),
      ),
      const Text(
        'Lorem ipsum dolor sit amet,\n consetetur sadipscing elitr,',
        style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 13,
            fontFamily: 'Montserrat Regular',
            color: AppColors.appColor0),
      ),
      Spacer(),
      GestureDetector(
        onTap: () {
          _controller.animateToPage(
            1,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            _videocontroller2.play();
          });
        },
        child: Container(
          padding: EdgeInsets.all(10),
          width: DeviceUtils.getScaledWidth(context, scale: 0.8),
          decoration: BoxDecoration(
            color: AppColors.appPrimaryColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: AppColors.appColor6,
                blurRadius: 10.0, // soften the shadow
                spreadRadius: 0.0, //extend the shadow
                offset: Offset(
                  0.0, // Move to right 10  horizontally
                  4.0, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          child: const Text(
            "Next",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                fontFamily: 'Montserrat Bold',
                color: AppColors.whiteColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.04),
      ),
    ],
  );
}

Widget ScreenTwo(context, _controller, _videocontroller2, _videocontroller3) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.01),
      ),
      Image.asset(
        'assets/images/logo.png',
        width: DeviceUtils.getScaledWidth(context, scale: 0.6),
        height: DeviceUtils.getScaledHeight(context, scale: 0.1),
        fit: BoxFit.contain,
      ),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.02),
      ),
      Container(
        width: DeviceUtils.getScaledWidth(context, scale: 0.4),
        height: DeviceUtils.getScaledHeight(context, scale: 0.35),
        child: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _videocontroller2.value.size?.width ?? 0,
              height: _videocontroller2.value.size?.height ?? 0,
              child: VideoPlayer(_videocontroller2),
            ),
          ),
        ),
      ),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.02),
      ),
      const Spacer(),
      Container(
          width: DeviceUtils.getScaledWidth(context, scale: 0.4),
          height: 8,
          decoration: BoxDecoration(
              color: AppColors.color1, borderRadius: BorderRadius.circular(10)),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                constraints: BoxConstraints(
                    minWidth: 10,
                    maxWidth: DeviceUtils.getScaledWidth(context, scale: 0.4)),
                height: 10,
                width: DeviceUtils.getScaledWidth(context, scale: 0.4) / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.appPrimaryColor),
                child: Text('')),
          )),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.07),
      ),
      const Text(
        'Easily reach out to Phlebotomists',
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            fontFamily: 'Montserrat ExtraBold',
            color: AppColors.appPrimaryColor),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.02),
      ),
      const Text(
        'Lorem ipsum dolor sit amet,\n consetetur sadipscing elitr,',
        style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 13,
            fontFamily: 'Montserrat Regular',
            color: AppColors.appColor0),
        textAlign: TextAlign.center,
      ),
      Spacer(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _controller.animateToPage(
                0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.03)),
              padding: EdgeInsets.all(10),
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.appColor6,
                    blurRadius: 10.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      4.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: const Icon(
                Icons.arrow_back,
                color: AppColors.appPrimaryColor,
                size: 25,
              )
            ),
          ),
          SizedBox(
            width: DeviceUtils.getScaledWidth(context, scale: 0.02),
          ),
          GestureDetector(
            onTap: () {
              _controller.animateToPage(
                2,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                _videocontroller3.play();
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              width: DeviceUtils.getScaledWidth(context, scale: 0.6),
              decoration: BoxDecoration(
                color: AppColors.appPrimaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.appColor6,
                    blurRadius: 10.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      4.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: const Text(
                "Next",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.whiteColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.04),
      ),
    ],
  );
}

Widget ScreenThree(context, _controller, _videocontroller3) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.01),
      ),
      Image.asset(
        'assets/images/logo.png',
        width: DeviceUtils.getScaledWidth(context, scale: 0.6),
        height: DeviceUtils.getScaledHeight(context, scale: 0.1),
        fit: BoxFit.contain,
      ),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.02),
      ),
      Container(
        width: DeviceUtils.getScaledWidth(context, scale: 0.6),
        height: DeviceUtils.getScaledHeight(context, scale: 0.45),
        child: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _videocontroller3.value.size?.width ?? 0,
              height: _videocontroller3.value.size?.height ?? 0,
              child: VideoPlayer(_videocontroller3),
            ),
          ),
        ),
      ),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.02),
      ),
      const Spacer(),
      Container(
          width: DeviceUtils.getScaledWidth(context, scale: 0.4),
          height: 8,
          decoration: BoxDecoration(
              color: AppColors.color1, borderRadius: BorderRadius.circular(10)),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                constraints: BoxConstraints(
                    minWidth: 10,
                    maxWidth: DeviceUtils.getScaledWidth(context, scale: 0.4)),
                height: 10,
                width: DeviceUtils.getScaledWidth(context, scale: 0.4) / 1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.appPrimaryColor),
                child: Text('')),
          )),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.07),
      ),
      const Text(
        'Fastest Health Application',
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            fontFamily: 'Montserrat ExtraBold',
            color: AppColors.appPrimaryColor),
        textAlign: TextAlign.center,
      ),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.02),
      ),
      const Text(
        'Lorem ipsum dolor sit amet,\n consetetur sadipscing elitr,',
        style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 13,
            fontFamily: 'Montserrat Regular',
            color: AppColors.appColor0),
        textAlign: TextAlign.center,
      ),
      Spacer(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _controller.animateToPage(
                1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: DeviceUtils.getScaledWidth(context, scale: 0.03)),
                padding: EdgeInsets.all(10),
                width: 50,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.appColor6,
                      blurRadius: 20.0, // soften the shadow
                      spreadRadius: 0.0, //extend the shadow
                      offset: Offset(
                        0.0, // Move to right 10  horizontally
                        10.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.appPrimaryColor,
                  size: 25,
                )
            ),
          ),
          SizedBox(
            width: DeviceUtils.getScaledWidth(context, scale: 0.02),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Welcome()));
            },
            child: Container(
              padding: EdgeInsets.all(10),
              width: DeviceUtils.getScaledWidth(context, scale: 0.6),
              decoration: BoxDecoration(
                color: AppColors.appPrimaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.appColor6,
                    blurRadius: 10.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      4.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.whiteColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: DeviceUtils.getScaledHeight(context, scale: 0.04),
      ),
    ],
  );
}
