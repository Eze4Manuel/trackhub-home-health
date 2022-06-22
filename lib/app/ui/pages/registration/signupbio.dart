import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/controller/authentication_controller.dart';
import 'package:trackhub_home_health/app/model/place_service.dart';
import 'package:trackhub_home_health/app/ui/pages/registration/verify_account.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';
import 'package:uuid/uuid.dart';

import '../profile/address_search.dart';

class SignUpBio extends StatefulWidget {
  const SignUpBio({Key? key}) : super(key: key);

  @override
  State<SignUpBio> createState() => _SignUpBioState();
}

class _SignUpBioState extends State<SignUpBio> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final _controller = TextEditingController();
  final AuthenticationController authenticationController =
      Get.put(AuthenticationController());

  String address = '';

  @override
  void initState() {}

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                    top: 270,
                    child: Image.asset(
                      'assets/images/bubble1.png',
                      width: DeviceUtils.getScaledWidth(context, scale: 0.7),
                      height: DeviceUtils.getScaledHeight(context, scale: 0.4),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    left: -25,
                    top: 255,
                    child: Image.asset(
                      'assets/images/bubble2.png',
                      width: DeviceUtils.getScaledWidth(context, scale: 0.8),
                      height: DeviceUtils.getScaledHeight(context, scale: 0.5),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: DeviceUtils.getScaledHeight(context, scale: 0.2)),
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
                maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.38),
                minHeight: DeviceUtils.getScaledHeight(context, scale: 0.38),
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
                          'Sign up Bio',
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
                                    'Address',
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
                                      controller: _controller,
                                      style: const TextStyle(
                                          fontSize: 13.0,
                                          fontFamily: 'Montserrat SemiBold',
                                          color: AppColors.appColor0),
                                      readOnly: true,
                                      decoration: InputDecorationValues03(
                                        hintText: 'example@abc.com',
                                        surfixIcon: const Icon(
                                          Icons.my_location,
                                          color: AppColors.appPrimaryColor,
                                          size: 25,
                                        ),
                                      ),
                                      validator: (value) {
                                        print(value);
                                        if (value!.isNotEmpty &&
                                            value.length < 3) {
                                          return 'Address not set';
                                        }
                                        return null;
                                      },
                                      onTap: () async {
                                        final sessionToken = const Uuid().v4();
                                        final Suggestions? result =
                                            await showSearch(
                                          context: context,
                                          delegate: AddressSearch(sessionToken),
                                        );
                                        // This will change the text displayed in the TextField
                                        if (result != null) {
                                          final placeDetails =
                                              await PlaceApiProvider(
                                                      sessionToken)
                                                  .getPlaceDetailFromId(
                                                      result.placeId);
                                          setState(() {
                                            _controller.text =
                                                result.description;
                                            address = result.description;
                                          });
                                        }
                                      },
                                      // onChanged: (val) {
                                      //   setState(() {});
                                      // },
                                    ),
                                  ),
                                  SizedBox(
                                    height: DeviceUtils.getScaledHeight(context,
                                        scale: 0.05),
                                  ),
                                  address.isNotEmpty
                                      ? RoundedLoadingButton(
                                          controller: _btnController,
                                          disabledColor: AppColors.appColor3,
                                          height: 45,
                                          borderRadius: 16,
                                          color: AppColors.appPrimaryColor,
                                          successColor:
                                              AppColors.appPrimaryColor,
                                          child: const Center(
                                            child: Text(
                                              'Finish',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat Bold',
                                                  color: AppColors.whiteColor),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          onPressed: () async {

                                            if (await authenticationController
                                                .updateAddress(
                                                AuthenticationController.user_email,
                                                    address,
                                                    AuthenticationController
                                                        .addressInfo)) {
                                              ToastWidget(
                                                  context,
                                                  authenticationController
                                                      .message.value,
                                                  authenticationController
                                                      .weight.value,
                                                  3);
                                              _btnController.reset();
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const VerifyAccount()));
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
                                          })
                                      : const Text(
                                          'Select your address or a landmark close to you to proceed',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontFamily: 'Montserrat SemiBold',
                                              color: AppColors.appPrimaryColor),
                                          textAlign: TextAlign.center,
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
