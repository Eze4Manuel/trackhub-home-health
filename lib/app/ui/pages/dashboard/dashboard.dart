import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/dashboard_controller.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:intl/intl.dart';
import '../home_health/lab_details.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool loading = true;
  bool fetching = false;
  static final DateTime now = DateTime.now();

  static final DateFormat formatter = DateFormat('EEEE, dd MMM');
  final String formatted = formatter.format(now);

  final DashboardController dashboardController =
      Get.put(DashboardController());

  late PanelController _controller;

  void getUserData() async {
    if (BaseController.user_data.isEmpty) {
      if (await dashboardController.getUserData()) {
        setState(() {
          loading = false;
        });
      }
      ;
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void fetchLabProviders() async {
    if (await dashboardController.getLabs()) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    _controller = PanelController();
    getUserData();
    fetchLabProviders();
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
          child: loading
              ? Container(
                  color: AppColors.appColor4,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white.withOpacity(0.5),
                      color: AppColors.appPrimaryColor,
                    ),
                  ),
                )
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.16),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: BaseController.laboratories.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  BaseController.selectedLab =
                                      BaseController.laboratories[index];
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          LabDetails(index: index)));
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: DeviceUtils.getScaledWidth(
                                                context,
                                                scale: 0.9),
                                            height: DeviceUtils.getScaledHeight(
                                                context,
                                                scale: 0.25),
                                            decoration: BoxDecoration(
                                                color: AppColors.tertiaryColor,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(
                                                                20)),
                                                image: BaseController
                                                                    .laboratories[
                                                                index]
                                                            ['image_url'] ==
                                                        null || BaseController
                                                    .laboratories[
                                                index]
                                                ['image_url'].toString().isEmpty
                                                    ? const DecorationImage(
                                                        image: AssetImage(
                                                          'assets/images/lab1.jpg',
                                                        ),
                                                        fit: BoxFit.cover)
                                                    : DecorationImage(
                                                        image: NetworkImage(
                                                            BaseController.laboratories[
                                                                        index][
                                                                    'image_url'] ??
                                                                ''),
                                                        fit: BoxFit.cover)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: DeviceUtils.getScaledWidth(context,
                                          scale: 0.9),
                                      height: DeviceUtils.getScaledHeight(
                                          context,
                                          scale: 0.1),
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              DeviceUtils.getScaledWidth(
                                                  context,
                                                  scale: 0.03)),
                                      decoration: const BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight:
                                                  Radius.circular(20))),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              BaseController.laboratories[index]
                                                  ['company_name'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  fontFamily: 'Montserrat Bold',
                                                  color: AppColors.appColor3),
                                            ),
                                          ),
                                          SizedBox(
                                            height: DeviceUtils.getScaledHeight(
                                                context,
                                                scale: 0.004),
                                          ),
                                          Flexible(
                                            child: Text(
                                              BaseController.laboratories[index]
                                                  ['address'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  fontFamily: 'Montserrat Bold',
                                                  color: AppColors.appColor3),
                                            ),
                                          ),
                                          SizedBox(
                                            height: DeviceUtils.getScaledHeight(
                                                context,
                                                scale: 0.004),
                                          ),
                                          Flexible(
                                            child: Text(
                                              BaseController.laboratories[index]
                                                          ['rating'] !=
                                                      null
                                                  ? BaseController
                                                      .laboratories[index]
                                                          ['rating']
                                                      .toString()
                                                  : '',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  fontFamily: 'Montserrat Bold',
                                                  color: AppColors
                                                      .appPrimaryColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: DeviceUtils.getScaledHeight(
                                          context,
                                          scale: 0.03),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.1),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              DeviceUtils.getScaledWidth(context, scale: 0.04),
                          vertical:
                              DeviceUtils.getScaledHeight(context, scale: 0.0)),
                      color: AppColors.appColor5,
                      height: DeviceUtils.getScaledHeight(context, scale: 0.14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.wb_sunny_rounded,
                                color: AppColors.secondaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                formatted,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    fontFamily: 'Montserrat Bold',
                                    color: AppColors.secondaryColor),
                              )
                            ],
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.02),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Hi, ${BaseController.user_data['first_name'] ?? ''}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 26,
                                  fontFamily: 'Montserrat Bold',
                                  color: AppColors.appColor0),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.01),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ));
  }
}

// Container(
//   padding: EdgeInsets.symmetric(
//     horizontal: DeviceUtils.getScaledWidth(context, scale: 0.04),
//   ),
//   child: loading
//       ? Container(
//           color: Colors.black.withOpacity(0),
//           child: Center(
//             child: CircularProgressIndicator(
//               backgroundColor: Colors.white.withOpacity(0.5),
//               color: AppColors.appPrimaryColor,
//             ),
//           ),
//         )
//       : SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height:
//                     DeviceUtils.getScaledHeight(context, scale: 0.06),
//               ),
//               Row(
//                 children: const [
//                   Icon(
//                     Icons.wb_sunny_rounded,
//                     color: AppColors.secondaryColor,
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     'Mon, 23rd May',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w400,
//                         fontSize: 16,
//                         fontFamily: 'Montserrat Bold',
//                         color: AppColors.secondaryColor),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height:
//                     DeviceUtils.getScaledHeight(context, scale: 0.02),
//               ),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Hi, Grace',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w400,
//                       fontSize: 26,
//                       fontFamily: 'Montserrat Bold',
//                       color: AppColors.appColor0),
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               SizedBox(
//                 height:
//                     DeviceUtils.getScaledHeight(context, scale: 0.01),
//               ),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'What would you like to do today?',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w400,
//                       fontSize: 14,
//                       fontFamily: 'Montserrat Bold',
//                       color: AppColors.appColor3),
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               SizedBox(
//                 height:
//                     DeviceUtils.getScaledHeight(context, scale: 0.03),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const RequestOne()));
//                 },
//                 child: ClipRRect(
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Container(
//                         width: DeviceUtils.getScaledWidth(context,
//                             scale: 0.9),
//                         height: DeviceUtils.getScaledHeight(context,
//                             scale: 0.25),
//                         decoration: const BoxDecoration(
//                             color: AppColors.appPrimaryColor,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(20))),
//                       ),
//                       Transform.translate(
//                         offset: const Offset(40.0, 20.0),
//                         child: Image.asset(
//                           'assets/images/book-ride.png',
//                           width: DeviceUtils.getScaledWidth(context,
//                               scale: 0.54),
//                           height: DeviceUtils.getScaledHeight(context,
//                               scale: 0.24),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const RequestOne()));
//                 },
//                 child: Container(
//                   width: DeviceUtils.getScaledWidth(context, scale: 0.9),
//                   height:
//                       DeviceUtils.getScaledHeight(context, scale: 0.07),
//                   padding: EdgeInsets.symmetric(
//                       horizontal: DeviceUtils.getScaledWidth(context,
//                           scale: 0.03)),
//                   decoration: const BoxDecoration(
//                       color: AppColors.whiteColor,
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(20),
//                           bottomRight: Radius.circular(20))),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Text(
//                         'Request Pickup',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16,
//                             fontFamily: 'Montserrat Bold',
//                             color: AppColors.appColor3),
//                       ),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: AppColors.appPrimaryColor,
//                         size: 30,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height:
//                     DeviceUtils.getScaledHeight(context, scale: 0.03),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const Labs()));
//                 },
//                 child: ClipRRect(
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Container(
//                         width: DeviceUtils.getScaledWidth(context,
//                             scale: 0.9),
//                         height: DeviceUtils.getScaledHeight(context,
//                             scale: 0.25),
//                         decoration: const BoxDecoration(
//                             color: AppColors.secondaryColor,
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20),
//                                 topRight: Radius.circular(20))),
//                       ),
//                       Transform.translate(
//                         offset: const Offset(40.0, 20.0),
//                         child: Image.asset(
//                           'assets/images/home-health.png',
//                           width: DeviceUtils.getScaledWidth(context,
//                               scale: 0.54),
//                           height: DeviceUtils.getScaledHeight(context,
//                               scale: 0.24),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (context) => const Labs()));
//                 },
//                 child: Container(
//                   width: DeviceUtils.getScaledWidth(context, scale: 0.9),
//                   height:
//                       DeviceUtils.getScaledHeight(context, scale: 0.07),
//                   padding: EdgeInsets.symmetric(
//                       horizontal: DeviceUtils.getScaledWidth(context,
//                           scale: 0.03)),
//                   decoration: const BoxDecoration(
//                       color: AppColors.whiteColor,
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(20),
//                           bottomRight: Radius.circular(20))),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Text(
//                         'Home Health',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16,
//                             fontFamily: 'Montserrat Bold',
//                             color: AppColors.appColor3),
//                       ),
//                       Icon(
//                         Icons.arrow_forward,
//                         color: AppColors.appPrimaryColor,
//                         size: 30,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
// )
