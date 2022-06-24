import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/dashboard_controller.dart';
import 'package:trackhub_home_health/app/ui/pages/requests/request_details.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';
import '../../../model/test.dart';
import 'address_setting.dart';

class HomeHealthRequest extends StatefulWidget {
  const HomeHealthRequest({Key? key}) : super(key: key);

  @override
  State<HomeHealthRequest> createState() => _HomeHealthRequestState();
}

class _HomeHealthRequestState extends State<HomeHealthRequest> {
  Test testRequest = Test();

  bool loading = true;
  String? test;
  bool visible = false;


  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late PanelController specimenController;
  late PanelController addressController;
  final TextEditingController _testMoreInfoTextFieldController =
      TextEditingController();

  DashboardController dashboardController = Get.put(DashboardController());
  late StreamSubscription<bool> keyboardSubscription;


  @override
  void initState() {
    specimenController = PanelController();
    addressController = PanelController();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((isVisible) {
      isVisible ? setState((){
        visible = true;
      }) : setState((){
        visible = false;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor6,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: DeviceUtils.getScaledWidth(context, scale: 1),
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.05)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Back',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: 'Montserrat ExtraBold',
                                color: AppColors.appColor3),
                          ),
                        ),
                        Expanded(
                            child: Transform.translate(
                          offset: const Offset(-20, 0),
                          child: const Center(
                              child: Text(
                            'Home Health',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: 'Montserrat Bold',
                                color: AppColors.appColor3),
                            textAlign: TextAlign.left,
                          )),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.medication_liquid_outlined,
                          size: 25,
                          color: AppColors.secondaryColor,
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 2,
                            // thickness of the line
                            indent: 10,
                            // empty space to the leading edge of divider.
                            endIndent: 10,
                            // empty space to the trailing edge of the divider.
                            color: AppColors.secondaryColor,
                            // The color to use when painting the line.
                            height: 10, // The divider's height extent.
                          ),
                        ),
                        Icon(
                          Icons.adjust,
                          size: 30,
                          color: AppColors.secondaryColor,
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 2,
                            // thickness of the line
                            indent: 10,
                            // empty space to the leading edge of divider.
                            endIndent: 10,
                            // empty space to the trailing edge of the divider.
                            color: AppColors.color13,
                            // The color to use when painting the line.
                            height: 10, // The divider's height extent.
                          ),
                        ),
                        Icon(
                          Icons.adjust,
                          size: 30,
                          color: AppColors.color13,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Place request for a Phlebotomist to provide home health',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor3),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Provide Request Info',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.whiteColor,
                      ),
                      child: TextFormField(
                        controller: _testMoreInfoTextFieldController,
                        maxLines: 10,
                        style: const TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Montserrat SemiBold',
                            color: AppColors.appColor0),
                        decoration:
                            InputDecorationValues02(hintText: 'More Info'),
                        onChanged: (val) {
                          setState(() {
                            BaseController.requestInfo = val.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.09),
                    ),

                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DeviceUtils.getScaledWidth(context, scale: 0.05)),
                child: Column(
                  children: [
                    RoundedLoadingButton(
                        controller: _btnController,
                        height: 45,
                        borderRadius: 16,
                        color: AppColors.appPrimaryColor,
                        successColor: AppColors.appPrimaryColor,
                        child: const Center(
                          child: Text(
                            'Done',
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
                          FocusManager.instance.primaryFocus?.unfocus();
                          setState(() {});
                          addressController.open();
                        }),
                    visible ?
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                    ):
                  SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.1),
                    ),
                  ],
                ),
              ),
            ),
            SlidingUpPanel(
              maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.29),
              minHeight: DeviceUtils.getScaledHeight(context, scale: 0),
              padding: EdgeInsets.symmetric(
                  vertical: DeviceUtils.getScaledHeight(context, scale: 0.0),
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.0)),
              margin: EdgeInsets.only(
                  bottom: DeviceUtils.getScaledHeight(context, scale: 0.072)),
              controller: addressController,
              backdropOpacity: 0.2,
              backdropEnabled: true,
              color: AppColors.whiteColor,
              backdropTapClosesPanel: true,
              panel: AddressSetting(
                  specimenController: specimenController,
                  addressController: addressController),
              boxShadow: const [],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            SlidingUpPanel(
              maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.8),
              minHeight: DeviceUtils.getScaledHeight(context, scale: 0),
              padding: EdgeInsets.symmetric(
                  vertical: DeviceUtils.getScaledHeight(context, scale: 0.02),
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.02)),
              margin: EdgeInsets.only(
                  bottom: DeviceUtils.getScaledHeight(context, scale: 0.072)),
              controller: specimenController,
              backdropOpacity: 0.2,
              backdropEnabled: true,
              color: AppColors.whiteColor,
              backdropTapClosesPanel: true,
              onPanelOpened: () {
                setState(() {});
              },
              panel: RequestDetail(
                orderLength: BaseController.getTestOrderLength(),
                lab: BaseController.selectedLab ?? {},
                selectedAddress: BaseController.getSelectedAddress() ?? {},
              ),
              boxShadow: const [],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
