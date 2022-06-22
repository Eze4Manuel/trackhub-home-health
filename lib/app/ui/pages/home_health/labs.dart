import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/ui/pages/home_health/lab_details.dart';
import 'package:trackhub_home_health/app/ui/pages/requests/request_one.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';

class Labs extends StatefulWidget {
  const Labs({Key? key}) : super(key: key);

  @override
  State<Labs> createState() => _LabsState();
}

class _LabsState extends State<Labs> {
  bool loading = false;
  bool fetching = false;

  late PanelController _controller;

  @override
  void initState() {
    _controller = PanelController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appColor6,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: DeviceUtils.getScaledWidth(context, scale: 0.04),
                vertical: DeviceUtils.getScaledHeight(context, scale: 0.0)),
            child: loading
                ? Container(
                    color: Colors.black.withOpacity(0),
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white.withOpacity(0.5),
                        color: AppColors.appPrimaryColor,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height:
                          DeviceUtils.getScaledHeight(context, scale: 0.02),
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.wb_sunny_rounded,
                              color: AppColors.secondaryColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Mon, 23rd May',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat Bold',
                                  color: AppColors.secondaryColor),
                            )
                          ],
                        ),
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.02),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Hi, Grace',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 26,
                                fontFamily: 'Montserrat Bold',
                                color: AppColors.appColor0),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.01),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'What would you like to do today?',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: 'Montserrat Bold',
                                color: AppColors.appColor3),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.03),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LabDetails()));
                          },
                          child: ClipRRect(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: DeviceUtils.getScaledWidth(context,
                                      scale: 0.9),
                                  height: DeviceUtils.getScaledHeight(context,
                                      scale: 0.25),
                                  decoration: const BoxDecoration(
                                    color: AppColors.appPrimaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/lab1.jpg'),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width:
                              DeviceUtils.getScaledWidth(context, scale: 0.9),
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.07),
                          padding: EdgeInsets.symmetric(
                              horizontal: DeviceUtils.getScaledWidth(context,
                                  scale: 0.03)),
                          decoration: const BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Flexible(
                                child: Text(
                                  'Ormeprzole Lab Intl',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat Bold',
                                      color: AppColors.appColor3),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  'Wuse',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                      fontFamily: 'Montserrat Regular',
                                      color: AppColors.appColor3),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.03),
                        ),
                        ClipRRect(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: DeviceUtils.getScaledWidth(context,
                                    scale: 0.9),
                                height: DeviceUtils.getScaledHeight(context,
                                    scale: 0.25),
                                decoration: const BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/lab2.jpg'), fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width:
                              DeviceUtils.getScaledWidth(context, scale: 0.9),
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.07),
                          padding: EdgeInsets.symmetric(
                              horizontal: DeviceUtils.getScaledWidth(context,
                                  scale: 0.03)),
                          decoration: const BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Flexible(
                                child: Text(
                                  'Ormeprzole Lab Intl',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat Bold',
                                      color: AppColors.appColor3),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.03),
                        ),
                        ClipRRect(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: DeviceUtils.getScaledWidth(context,
                                    scale: 0.9),
                                height: DeviceUtils.getScaledHeight(context,
                                    scale: 0.25),
                                decoration: const BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/lab3.jpg'), fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width:
                              DeviceUtils.getScaledWidth(context, scale: 0.9),
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.07),
                          padding: EdgeInsets.symmetric(
                              horizontal: DeviceUtils.getScaledWidth(context,
                                  scale: 0.03)),
                          decoration: const BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Flexible(
                                child: Text(
                                  'Ormeprzole Lab Intl',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat Bold',
                                      color: AppColors.appColor3),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.03),
                        ),
                        ClipRRect(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: DeviceUtils.getScaledWidth(context,
                                    scale: 0.9),
                                height: DeviceUtils.getScaledHeight(context,
                                    scale: 0.25),
                                decoration: const BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/lab4.jpg'), fit: BoxFit.cover),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          width:
                              DeviceUtils.getScaledWidth(context, scale: 0.9),
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.07),
                          padding: EdgeInsets.symmetric(
                              horizontal: DeviceUtils.getScaledWidth(context,
                                  scale: 0.03)),
                          decoration: const BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Flexible(
                                child: Text(
                                  "Omepazole Lab Int'l Omepazole Lab Int'l Omepazole Lab Int'l ",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat Bold',
                                      color: AppColors.appColor3),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                              DeviceUtils.getScaledHeight(context, scale: 0.15),
                        ),
                      ],
                    ),
                  ),
          ),
        ));
  }
}
