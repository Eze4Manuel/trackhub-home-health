import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/controller/profile_controller.dart';
import 'package:trackhub_home_health/app/ui/pages/profile/change_password.dart';
import 'package:trackhub_home_health/app/ui/pages/profile/edit_profile.dart';
import 'package:trackhub_home_health/app/ui/pages/registration/login.dart';
import 'package:trackhub_home_health/app/ui/pages/tickets/tickets.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';
import '../../../controller/base_controller.dart';
import 'address_update.dart';

enum ImageSourceType { gallery, camera }

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  NumberFormat myFormat = NumberFormat.compact(locale: 'en_US');
  final ProfileController profileController = Get.put(ProfileController());
  late PanelController _addressSearchController;
  String? savedImage;

  @override
  void initState() {
    _addressSearchController = PanelController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    savedImage = BaseController.user_data['image_url'];

    return Scaffold(
      backgroundColor: AppColors.appColor5,
      body: Container(
        height: DeviceUtils.getScaledHeight(context, scale: 1),
        color: AppColors.appColor6,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: DeviceUtils.getScaledHeight(context, scale: 0.03),
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.04)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                    ),
                    const Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: 'Montserrat ExtraBold',
                            color: AppColors.appColor0),
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                    ),
                    Container(
                      child: Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(108.0),
                            child: BaseController.user_data['image_url']
                                    .toString()
                                    .isEmpty
                                ? Image.asset(
                                    'assets/images/profile.png',
                                    height: 140.0,
                                    width: 140.0,
                                    color: BaseController.user_data['image_url']
                                            .toString()
                                            .isEmpty
                                        ? AppColors.tertiaryColor
                                        : null,
                                  )
                                : Container(
                                    color: AppColors.tertiaryColor,
                                    child: Image.network(
                                      savedImage!,
                                      height: 100.0,
                                      width: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    Center(
                      child: Text(
                        '${BaseController.user_data['first_name']} ${BaseController.user_data['last_name']}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: 'Montserrat ExtraBold',
                            color: AppColors.appColor0),
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.05),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Analytic(
                            value: myFormat.format(270000),
                            title: 'Total \n Rides'),
                        SizedBox(
                          width:
                              DeviceUtils.getScaledWidth(context, scale: 0.02),
                        ),
                        Analytic(
                            value: myFormat.format(270000),
                            title: 'Total \n Kilometers'),
                        SizedBox(
                          width:
                              DeviceUtils.getScaledWidth(context, scale: 0.02),
                        ),
                        Analytic(
                            value: myFormat.format(270000),
                            title: 'Total \n Completed')
                      ],
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.05),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(13)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const EditProfile()));
                        },
                        tileColor: AppColors.whiteColor,
                        dense: true,
                        leading: const Icon(
                          Icons.person_add_alt_1_rounded,
                          color: AppColors.appPrimaryColor,
                        ),
                        title: const Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Montserrat ExtraBold',
                              color: AppColors.appColor0),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.color13,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height:
                          DeviceUtils.getScaledHeight(context, scale: 0.015),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(13)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const ChangePassword()));
                        },
                        tileColor: AppColors.whiteColor,
                        dense: true,
                        leading: const Icon(
                          Icons.lock_rounded,
                          color: AppColors.appPrimaryColor,
                        ),
                        title: const Text(
                          'Change Password',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Montserrat ExtraBold',
                              color: AppColors.appColor0),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: AppColors.color13, size: 20),
                      ),
                    ),
                    SizedBox(
                      height:
                          DeviceUtils.getScaledHeight(context, scale: 0.015),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(13)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: const Tickets()));
                        },
                        tileColor: AppColors.whiteColor,
                        dense: true,
                        leading: const Icon(
                          Icons.airplane_ticket_rounded,
                          color: AppColors.appPrimaryColor,
                        ),
                        title: const Text(
                          'Ticket',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Montserrat ExtraBold',
                              color: AppColors.appColor0),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: AppColors.color13, size: 20),
                      ),
                    ),
                    SizedBox(
                      height:
                          DeviceUtils.getScaledHeight(context, scale: 0.015),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(13)),
                      child: ListTile(
                        onTap: () {
                          _addressSearchController.open();
                        },
                        tileColor: AppColors.whiteColor,
                        dense: true,
                        leading: const Icon(
                          Icons.airplane_ticket_rounded,
                          color: AppColors.appPrimaryColor,
                        ),
                        title: const Text(
                          'Update Address',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Montserrat ExtraBold',
                              color: AppColors.appColor0),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: AppColors.color13, size: 20),
                      ),
                    ),
                    SizedBox(
                      height:
                          DeviceUtils.getScaledHeight(context, scale: 0.015),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(13)),
                      child: ListTile(
                        onTap: () async {
                          if (await profileController.logout()) {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const Login()));
                          }
                        },
                        tileColor: AppColors.whiteColor,
                        dense: true,
                        leading: const Icon(
                          Icons.airplane_ticket_rounded,
                          color: AppColors.appPrimaryColor,
                        ),
                        title: const Text(
                          'Logout',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Montserrat ExtraBold',
                              color: AppColors.appColor0),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            color: AppColors.color13, size: 20),
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.12),
                    ),
                    const Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Text(
                        'copyright @ 2022',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Montserrat ExtraBold',
                            color: AppColors.appColor0),
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.1),
                    ),
                  ],
                ),
              ),
            ),
            SlidingUpPanel(
              maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.31),
              minHeight: DeviceUtils.getScaledHeight(context, scale: 0),
              padding: EdgeInsets.symmetric(
                  vertical: DeviceUtils.getScaledHeight(context, scale: 0.02),
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.02)),
              margin: EdgeInsets.only(
                  bottom: DeviceUtils.getScaledHeight(context, scale: 0.072)),
              controller: _addressSearchController,
              backdropOpacity: 0.2,
              backdropEnabled: true,
              color: AppColors.whiteColor,
              backdropTapClosesPanel: true,
              onPanelOpened: () {
                setState(() {});
              },
              panel: AddressUpdate(
                  addressSearchController: _addressSearchController),
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
