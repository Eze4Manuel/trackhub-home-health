
import 'package:flutter/material.dart';
import 'package:trackhub_home_health/app/ui/pages/registration/login.dart';
import 'package:trackhub_home_health/app/ui/pages/registration/signup.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:video_player/video_player.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late VideoPlayerController _videocontroller;


  @override
  void initState() {
    super.initState();
    _videocontroller = VideoPlayerController.asset(
        'assets/videos/intro4.mp4')..initialize().then((_) {
      setState(() {});
    });
    _videocontroller.setLooping(false);
  }

  @override
  Widget build(BuildContext context) {
    _videocontroller.play();
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.1),
              ),
              const Text(
                'Welcome to,',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    fontFamily: 'Montserrat ExtraBold',
                    color: AppColors.appPrimaryColor),
              ),
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
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, scale: 0.5),
                height: DeviceUtils.getScaledHeight(context, scale: 0.4),
                child: SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videocontroller.value.size.width,
                      height: _videocontroller.value.size.height,
                      child: VideoPlayer(_videocontroller),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              const Spacer(),

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

              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.03),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: DeviceUtils.getScaledWidth(context, scale: 0.8),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: AppColors.appPrimaryColor,  // red as border color
                        width: 2
                    ),
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.color13,
                        blurRadius: 35.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                        offset: Offset(
                          0.0, // Move to right 10  horizontally
                          5.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                  child: const Text(
                    "Log in",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        fontFamily: 'Montserrat Bold',
                        color: AppColors.appPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Signup()));
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: DeviceUtils.getScaledWidth(context, scale: 0.8),
                  decoration: BoxDecoration(
                    color: AppColors.appPrimaryColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.color13,
                        blurRadius: 35.0, // soften the shadow
                        spreadRadius: 0.0, //extend the shadow
                        offset: Offset(
                          0.0, // Move to right 10  horizontally
                          15.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                  child: const Text(
                    "Create Account",
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
                height: DeviceUtils.getScaledHeight(context, scale: 0.05),
              ),
            ],
          )
      ),
    );
  }
}
