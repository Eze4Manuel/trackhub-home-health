import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/controller/authentication_controller.dart';
import 'package:trackhub_home_health/app/ui/pages/dashboard/home.dart';
import 'package:trackhub_home_health/app/ui/pages/registration/forgot_password.dart';
import 'package:trackhub_home_health/app/ui/pages/registration/signup.dart';
import 'package:trackhub_home_health/app/ui/pages/registration/verify_account.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/ui/theme/app_strings.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final AuthenticationController authenticationController = Get.put(AuthenticationController());

  // Phone field variables
  bool valid = false;

  // Input field variables
  String nameField = '';
  String password = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              height: DeviceUtils.getScaledHeight(context, scale: 0.5),
              width: DeviceUtils.getScaledWidth(context, scale: 1),
              color: AppColors.tertiaryColor,
              child: Stack(
                children: [
                  Positioned(
                    right: -60,
                    top: 150,
                    child: Image.asset(
                      'assets/images/bubble1.png',
                      width: DeviceUtils.getScaledWidth(context, scale: 0.7),
                      height: DeviceUtils.getScaledHeight(context, scale: 0.4),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    left: -25,
                    top: 155,
                    child: Image.asset(
                      'assets/images/bubble2.png',
                      width: DeviceUtils.getScaledWidth(context, scale: 0.8),
                      height: DeviceUtils.getScaledHeight(context, scale: 0.5),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: DeviceUtils.getScaledWidth(context, scale: 0.6),
                      height: DeviceUtils.getScaledHeight(context, scale: 0.2),
                      fit: BoxFit.contain,
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
                maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.63),
                minHeight: DeviceUtils.getScaledHeight(context, scale: 0.63),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                panel: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          DeviceUtils.getScaledHeight(context, scale: 0.03),
                      horizontal:
                          DeviceUtils.getScaledWidth(context, scale: 0.07)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02)),
                        const Text(
                          Strings.loginToRider,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              fontFamily: 'Montserrat ExtraBold',
                              color: AppColors.appPrimaryColor),
                        ),
                        SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.03)),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Email / Username',
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
                                          color: AppColors.appColor0
                                      ),
                                      decoration:
                                      InputDecorationValues02(hintText: 'example@abc.com'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Field cannot be empty';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          nameField = val.toString();
                                        });
                                      },
                                    ),
                                  ),

                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.02),
                                  ),
                                  const Text(
                                    'Password',
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
                                          color: AppColors.appColor0
                                      ),
                                      obscureText: true,
                                      decoration:
                                      InputDecorationValues02(hintText: '******'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Input password';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                            password = val.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.02),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ForgotPassword()));
                                      },
                                      child: const Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            fontFamily: 'Montserrat ExtraBold',
                                            color: AppColors.appPrimaryColor),
                                        textAlign: TextAlign.right,
                                      ),
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
                                          'Log in',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat Bold',
                                              color: AppColors.whiteColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      onPressed: () async {
                                        _btnController.reset();
                                        if(_formKey.currentState!.validate()){
                                          if ( await authenticationController
                                              .loginUserAccount( nameField, password)) {
                                            ToastWidget(
                                                context, authenticationController.message.value, authenticationController.weight.value, 3);
                                            _btnController.reset();
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                                          } else {
                                            ToastWidget(
                                                context, authenticationController.message.value, authenticationController.weight.value, 3);
                                            if(authenticationController.message.value == 'Account not verified'){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const VerifyAccount()));
                                            }
                                            _btnController.reset();
                                          }
                                        }else {
                                          _btnController.reset();
                                        }
                                      }),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.02),
                                  ),
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '- Or continue with -',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          fontFamily: 'Montserrat Bold',
                                          color: AppColors.appPrimaryColor),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/google.png',
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.contain,
                                      ),
                                    SizedBox(
                                      width: DeviceUtils.getScaledWidth(context, scale: 0.03),
                                    ),
                                      Image.asset(
                                        'assets/images/facebook.png',
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.contain,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.02),
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Don't have an account? ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            fontFamily: 'Montserrat Bold',
                                            color: AppColors.appPrimaryColor),
                                        textAlign: TextAlign.right,
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Signup()));
                                        },
                                        child: const Text(
                                          " Sign Up",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              fontFamily: 'Montserrat Bold',
                                              color: AppColors.appPrimaryColor),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
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
