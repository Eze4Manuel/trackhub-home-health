import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/controller/authentication_controller.dart';
import 'package:trackhub_home_health/app/ui/pages/registration/login.dart';
import 'package:trackhub_home_health/app/ui/pages/registration/resend_verification.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';

class VerifyAccount extends StatefulWidget {
  const VerifyAccount({Key? key}) : super(key: key);

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();
  final AuthenticationController authenticationController =
  Get.put(AuthenticationController());

  // Phone field variables
  final TextEditingController _textController = TextEditingController();
  final String initialCountry = 'NG';
  final PhoneNumber number = PhoneNumber(isoCode: 'NG');
  bool valid = false;
  String code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              height: DeviceUtils.getScaledHeight(context, scale: 0.9),
              width: DeviceUtils.getScaledWidth(context, scale: 1),
              padding: EdgeInsets.only(top: DeviceUtils.getScaledHeight(context, scale: 0.2)),
              color: AppColors.tertiaryColor,
              child: Stack(
                children: [
                  Positioned(
                    right: -60,
                    top: 130,
                    child: Image.asset(
                      'assets/images/bubble1.png',
                      width: DeviceUtils.getScaledWidth(context, scale: 0.7),
                      height: DeviceUtils.getScaledHeight(context, scale: 0.4),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    left: -45,
                    top: 108,
                    child: Image.asset(
                      'assets/images/bubble2.png',
                      width: DeviceUtils.getScaledWidth(context, scale: 0.8),
                      height: DeviceUtils.getScaledHeight(context, scale: 0.5),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
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
                maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.4),
                minHeight: DeviceUtils.getScaledHeight(context, scale: 0.4),
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
                          'Verify Account',
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
                                    'Enter the Code sent to your email',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        fontFamily: 'Montserrat Bold',
                                        color: AppColors.appPrimaryColor),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.01),
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
                                      InputDecorationValues02(hintText: '123456'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'No code inserted';
                                        }else if(value.length != 6){
                                          return 'Invalid code inserted';
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
                                        scale: 0.01),
                                  ),
                                   Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ResendVerification()));
                                        },
                                        child: const Text('Resend Code',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              fontFamily: 'Montserrat Bold',
                                              color: AppColors.appPrimaryColor)
                                        ),
                                      )),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.04),
                                  ),

                                  RoundedLoadingButton(
                                      controller: _btnController,
                                      height: 45,
                                      borderRadius: 16,
                                      color: AppColors.appPrimaryColor,
                                      successColor: AppColors.appPrimaryColor,
                                      child: const Center(
                                        child: Text(
                                          'Submit',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              fontFamily: 'Montserrat Bold',
                                              color: AppColors.whiteColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      onPressed: () async {
                                         if(_formKey.currentState!.validate()){
                                          if ( await authenticationController
                                              .verifyAccount( code)) {
                                            ToastWidget(
                                                context, authenticationController.message.value, authenticationController.weight.value, 3);
                                            _btnController.reset();
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()));
                                          } else {
                                            ToastWidget(
                                                context, authenticationController.message.value, authenticationController.weight.value, 3);
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

                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.02),
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
