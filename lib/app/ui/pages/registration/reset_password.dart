import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/controller/authentication_controller.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/model/account.dart';
import 'package:trackhub_home_health/app/ui/pages/registration/login.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  final AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  // Phone field variables
  final TextEditingController _textController = TextEditingController();
  final String initialCountry = 'NG';
  final PhoneNumber number = PhoneNumber(isoCode: 'NG');
  String? code;
  String? newPassword;
  String? confirmPassword;
  bool? confirmPasswordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              height: DeviceUtils.getScaledHeight(context, scale: 1),
              width: DeviceUtils.getScaledWidth(context, scale: 1),
              color: AppColors.tertiaryColor,
              child: Stack(
                children: [
                  Positioned(
                    right: -60,
                    top: 190,
                    child: Image.asset(
                      'assets/images/bubble1.png',
                      width: DeviceUtils.getScaledWidth(context, scale: 0.7),
                      height: DeviceUtils.getScaledHeight(context, scale: 0.4),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    left: -25,
                    top: 195,
                    child: Image.asset(
                      'assets/images/bubble2.png',
                      width: DeviceUtils.getScaledWidth(context, scale: 0.8),
                      height: DeviceUtils.getScaledHeight(context, scale: 0.5),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: DeviceUtils.getScaledHeight(context, scale: 0.14)),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: DeviceUtils.getScaledWidth(context, scale: 0.6),
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.2),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SlidingUpPanel(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 35.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      15.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
                maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.6),
                minHeight: DeviceUtils.getScaledHeight(context, scale: 0.6),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                panel: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          DeviceUtils.getScaledHeight(context, scale: 0.02),
                      horizontal:
                          DeviceUtils.getScaledWidth(context, scale: 0.07)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.015)),
                        const Text(
                          'Reset Password',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              fontFamily: 'Montserrat ExtraBold',
                              color: AppColors.appPrimaryColor),
                        ),
                        SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.015)),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Reset code',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        fontFamily: 'Montserrat Bold',
                                        color: AppColors.appPrimaryColor),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: AppColors.appColor4,
                                    ),
                                    child: TextFormField(
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Montserrat SemiBold',
                                          color: AppColors.appColor0),
                                      decoration: InputDecorationValues02(
                                          hintText: 'John'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Insert Code sent to Email';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          code = val.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.02),
                                  ),
                                  const Text(
                                    'New Password',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        fontFamily: 'Montserrat Bold',
                                        color: AppColors.appPrimaryColor),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: AppColors.appColor4,
                                    ),
                                    child: TextFormField(
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Montserrat SemiBold',
                                          color: AppColors.appColor0),
                                      obscureText: true,
                                      decoration: InputDecorationValues02(
                                          hintText: '******'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Password is required';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          newPassword = val.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.015),
                                  ),
                                  const Text(
                                    'Confirm Password',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        fontFamily: 'Montserrat Bold',
                                        color: AppColors.appPrimaryColor),
                                    textAlign: TextAlign.center,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: AppColors.appColor4,
                                    ),
                                    child: TextFormField(
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Montserrat SemiBold',
                                          color: AppColors.appColor0),
                                      decoration: InputDecorationValues02(
                                          hintText: '******'),
                                      obscureText: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Confirm Password';
                                        } else if (value != newPassword) {
                                          return 'Password confirm failed ';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          confirmPassword = val.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.03),
                                  ),
                                  RoundedLoadingButton(
                                      controller: _btnController,
                                      height: 45,
                                      borderRadius: 16,
                                      color: AppColors.appPrimaryColor,
                                      successColor: AppColors.appPrimaryColor,
                                      child: const Center(
                                        child: Text(
                                          'Continue',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat Bold',
                                              color: AppColors.whiteColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      onPressed: () async {


                                        if (_formKey.currentState!.validate()) {
                                            if (await authenticationController
                                              .resetPassword(code!, newPassword!)) {
                                            ToastWidget(
                                                context,
                                                authenticationController
                                                    .message.value,
                                                authenticationController
                                                    .weight.value,
                                                3);
                                            _btnController.reset();
                                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
                                            } else {

                                            ToastWidget(
                                                context,
                                                authenticationController
                                                    .message.value,
                                                authenticationController
                                                    .weight.value,
                                                3);
                                            _btnController.reset();
                                          }
                                        } else {
                                          _btnController.reset();
                                        }
                                      }),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.02),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Already have an account? ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              fontFamily: 'Montserrat Bold',
                                              color: AppColors.appPrimaryColor),
                                          textAlign: TextAlign.right,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Login()));
                                          },
                                          child: const Text(
                                            " Log in",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                fontFamily: 'Montserrat Bold',
                                                color:
                                                    AppColors.appPrimaryColor),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.02),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }
}
