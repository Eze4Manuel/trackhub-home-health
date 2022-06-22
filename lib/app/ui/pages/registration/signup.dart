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
import 'package:trackhub_home_health/app/ui/pages/registration/signupbio.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();

  final AuthenticationController authenticationController = Get.put(AuthenticationController());

  // Phone field variables
  final TextEditingController _textController = TextEditingController();
  final String initialCountry = 'NG';
  final PhoneNumber number = PhoneNumber(isoCode: 'NG');
  Account account = Account();
  bool valid = false;


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
                    top: 0,
                    child: Image.asset(
                      'assets/images/bubble1.png',
                      width: DeviceUtils.getScaledWidth(context, scale: 0.7),
                      height: DeviceUtils.getScaledHeight(context, scale: 0.4),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    left: -25,
                    top: 5,
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
                maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.8),
                minHeight: DeviceUtils.getScaledHeight(context, scale: 0.8),
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
                          'Sign up',
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
                                    'First Name',
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
                                      InputDecorationValues02(hintText: 'John'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'First Name is required';
                                        }
                                        if (value.isNotEmpty && value.length < 3) {
                                          return 'First Name too short';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          account.first_name = val.toString();
                                        });
                                      },
                                    ),
                                  ),

                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.02),
                                  ),
                                  const Text(
                                    'Last Name',
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
                                      InputDecorationValues02(hintText: 'Doee'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Last Name is required';
                                        }
                                        if (value.isNotEmpty && value.length < 3) {
                                          return 'Last Name too short';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          account.last_name = val.toString();
                                        });
                                      },
                                    ),
                                  ),

                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.015),
                                  ),
                                  const Text(
                                    'Email',
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
                                          return 'Email is required';
                                        }
                                        if (!BaseController.emailRegex
                                            .hasMatch(value)) {
                                          return 'Enter a Valid Email Address';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          account.email = val.toString();
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.015),
                                  ),
                                  const Text(
                                    'Username',
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
                                      InputDecorationValues02(hintText: 'trachub4life'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Username is required';
                                        }
                                        if (value.isNotEmpty && value.length < 3) {
                                          return 'Username too short';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          account.username = val.toString();
                                        });
                                      },
                                    ),
                                  ),

                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.015),
                                  ),
                                  const Text(
                                    'Phone Number',
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
                                    child: InternationalPhoneNumberInput(
                                      textStyle: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Montserrat Bold',
                                          color: AppColors.color10),
                                      inputDecoration: InputDecorationValues02(
                                          hintText: "phone number"),
                                      onInputChanged: (PhoneNumber number) {
                                        setState(() {
                                          account.phone_number = number.toString();
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Enter Your Phone Number';
                                        }
                                        if (!valid) {
                                          return 'Incorrect Phone Number';
                                        }
                                        return null;
                                      },
                                      onInputValidated: (bool value) {
                                        setState(() {
                                          valid = value;
                                        });
                                      },
                                      selectorConfig: const SelectorConfig(
                                          selectorType:
                                          PhoneInputSelectorType.BOTTOM_SHEET,
                                          leadingPadding: 0,
                                          trailingSpace: false,
                                          setSelectorButtonAsPrefixIcon: true),
                                      ignoreBlank: false,
                                      autoValidateMode: AutovalidateMode.disabled,
                                      selectorTextStyle: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: 'Montserrat Bold',
                                          color: AppColors.color10),
                                      initialValue: number,
                                      textFieldController: _textController,
                                      formatInput: false,
                                      maxLength: 11,
                                      keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true, decimal: true),
                                      inputBorder: const OutlineInputBorder(),
                                      onSaved: (PhoneNumber number) {
                                        if (kDebugMode) {
                                          print('On Saved: $number');
                                        }
                                      },
                                    ),
                                  ),

                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.015),
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
                                      decoration:
                                      InputDecorationValues02(hintText: '******'),
                                      obscureText: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Password is required';
                                        }
                                        return null;
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          account.password = val.toString();
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

                                        if(_formKey.currentState!.validate()){
                                          if ( await authenticationController
                                              .signUpAccount( account)) {
                                            ToastWidget(
                                                context, authenticationController.message.value, authenticationController.weight.value, 3);
                                            _btnController.reset();
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SignUpBio()));
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

                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                          onTap: (){
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
                                          },
                                          child: const Text(
                                            " Log in",
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
