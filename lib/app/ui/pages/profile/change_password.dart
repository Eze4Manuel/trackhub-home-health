
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:intl/intl.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';

import '../../../controller/profile_controller.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  String current_password = '';
  String new_password = '';
  String confirm_password = '';

  final _formKey = GlobalKey<FormState>();

  final ProfileController profileController = Get.put(ProfileController());

  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();
  late PanelController _controller;

  @override
  void initState() {
    _controller = PanelController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
        body: Stack(
        children: [
          Container(
            height: DeviceUtils.getScaledHeight(context, scale: 1),
            color: AppColors.appColor4,
            padding: EdgeInsets.symmetric(
                vertical: DeviceUtils.getScaledHeight(context, scale: 0.03),
                horizontal: DeviceUtils.getScaledWidth(context, scale: 0.04)
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: DeviceUtils.getScaledWidth(context, scale: 1),
                    minHeight: DeviceUtils.getScaledHeight(context, scale: 1),
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: DeviceUtils.getScaledHeight(
                              context,
                              scale: 0.03),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Montserrat ExtraBold',
                                    color: AppColors.appColor0),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: DeviceUtils.getScaledHeight(
                              context,
                              scale: 0.0),
                        ),
                        const Center(
                          child: Text(
                            'Change Password',
                            style: TextStyle(
                                fontWeight:
                                FontWeight.w400,
                                fontSize: 16,
                                fontFamily:
                                'Montserrat ExtraBold',
                                color: AppColors
                                    .appColor0),
                          ),
                        ),

                        SizedBox(
                          height: DeviceUtils.getScaledHeight(context,
                              scale: 0.04),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Current Password',
                            style: TextStyle(
                                fontWeight:
                                FontWeight.w400,
                                fontSize: 13,
                                fontFamily:
                                'Montserrat Bold',
                                color: AppColors
                                    .appColor0),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: DeviceUtils.getScaledHeight(context,
                              scale: 0.01),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextFormField(
                            style: const TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Montserrat SemiBold',
                                color: AppColors.appColor0
                            ),

                            decoration:
                            InputDecorationValues02(hintText: '******'),
                            validator: (value) {
                              if (value!.length == 0) {
                                return 'Required';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                current_password = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: DeviceUtils.getScaledHeight(
                              context,
                              scale: 0.02),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'New Password',
                            style: TextStyle(
                                fontWeight:
                                FontWeight.w400,
                                fontSize: 13,
                                fontFamily:
                                'Montserrat Bold',
                                color: AppColors
                                    .appColor0),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: DeviceUtils.getScaledHeight(context,
                              scale: 0.01),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: TextFormField(
                            obscuringCharacter: '*',
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
                                return 'Required';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                new_password = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: DeviceUtils.getScaledHeight(
                              context,
                              scale: 0.02),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Re-Enter Password',
                            style: TextStyle(
                                fontWeight:
                                FontWeight.w400,
                                fontSize: 13,
                                fontFamily:
                                'Montserrat Bold',
                                color: AppColors
                                    .appColor0),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: DeviceUtils.getScaledHeight(context,
                              scale: 0.01),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
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
                              if (value!.length == 0) {
                                return 'Required';
                              }
                              if(new_password != confirm_password){
                                return 'Password does not match';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                confirm_password = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: DeviceUtils.getScaledHeight(
                              context,
                              scale: 0.02),
                        ),
                        const Spacer(),
                        RoundedLoadingButton(
                            controller: _btnController,
                            height: 40,
                            borderRadius: 10,
                            color: AppColors.appPrimaryColor,
                            successColor: AppColors.appPrimaryColor,
                            child: const Center(
                              child: Text(
                                'Update',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    fontFamily: 'Montserrat SemiBold',
                                    color: AppColors.whiteColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            onPressed: () async {
                              if(_formKey.currentState!.validate()){
                                if (await profileController
                                    .updateUserPassword(current_password, new_password)) {
                                  ToastWidget(
                                      context, profileController.message.value, profileController.weight.value, 3);
                                  _btnController.reset();
                                  // _controller.open();
                                } else {
                                  ToastWidget(
                                      context, profileController.message.value, profileController.weight.value, 3);
                                  _btnController.reset();
                                }
                              }else _btnController.reset();
                            }),
                        SizedBox(
                          height: DeviceUtils.getScaledHeight(
                              context,
                              scale: 0.15),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SlidingUpPanel(
            maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.43),
            minHeight: DeviceUtils.getScaledHeight(context, scale: 0),
            controller: _controller,
            backdropOpacity: 0.2,
            backdropEnabled: true,
            backdropTapClosesPanel: true,
            panel: SuccessfulUpdate(
                controller: _controller),
            boxShadow: [],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          )
        ],
      ),
    );
  }
}




class SuccessfulUpdate extends StatefulWidget {
  PanelController controller;
  SuccessfulUpdate({Key? key, required this.controller}) : super(key: key);

  @override
  State<SuccessfulUpdate> createState() => _SuccessfulUpdateState();
}

class _SuccessfulUpdateState extends State<SuccessfulUpdate> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          Container(
            width: DeviceUtils.getScaledWidth(context, scale: 0.09),
            height: DeviceUtils.getScaledHeight(context, scale: 0.007),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.color13),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.03),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.appColor2,
                borderRadius: BorderRadius.circular(100)

            ),
            child: const Icon( Icons.check,
              color: AppColors.whiteColor,
              size: 40,
            ),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          const Text(
            'Successful',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                fontFamily: 'Montserrat ExtraBold',
                color: AppColors.appColor0),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          const Text(
            'You have successfully updated \nyour profile',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'Montserrat Regular',
                color: AppColors.appColor0),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.03),
          ),

          GestureDetector(
            onTap: () {
              widget.controller.close();
            },
            child: Container(
              width:
              DeviceUtils.getScaledWidth(context, scale: 0.7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.appPrimaryColor),
              padding: const EdgeInsets.symmetric(
                  horizontal: 25, vertical: 12),
              child: const Text(
                'Done',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.whiteColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
