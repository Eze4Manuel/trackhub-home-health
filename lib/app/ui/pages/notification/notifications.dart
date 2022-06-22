import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackhub_home_health/app/controller/notification_controller.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';

import '../../../controller/base_controller.dart';


class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final NotificationController notificationController =
      Get.put(NotificationController());

  bool loading = false;
  bool fetched = true;

  void getNotifications() async {
    if (await notificationController.getNotifications()) {
      if (BaseController.notifications != null) {
        setState(() {
          loading = false;
        });
      }
    }
  }
  void caller() {
    BaseController.persistentController.addListener(() {
      if (BaseController.persistentController.index == 2) {
        getNotifications();
      }else{
      }
    });
  }

  @override
  void initState() {
    caller();
    getNotifications();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Container(
        height: DeviceUtils.getScaledHeight(context, scale: 1),
        width: DeviceUtils.getScaledWidth(context, scale: 1),
        color: AppColors.appColor4,
        padding: EdgeInsets.symmetric(
            vertical: DeviceUtils.getScaledHeight(context, scale: 0.03),
            horizontal: DeviceUtils.getScaledWidth(context, scale: 0.03)),
        child: Column(
          children: [
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.03),
            ),
            const Text(
              'Notifications',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  fontFamily: 'Montserrat ExtraBold',
                  color: AppColors.appColor0),
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.02),
            ),
            Container(
              height: DeviceUtils.getScaledHeight(context, scale: 0.8),
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: AppColors.appPrimaryColor,
                        color: AppColors.whiteColor,
                        strokeWidth: 5,
                      ),
                    )
                  : ListView.builder(
                      itemCount: 0,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // if(await notificationController.updateNotification(BaseController.notifications[index]
                                // ["_id"])){
                                //   if (BaseController.notifications[index]
                                //   ["type"] ==
                                //       'dispatch') {
                                //     BaseController.notifications.removeWhere((element) => (element['_id'] == BaseController.notifications[index]
                                //     ["_id"])
                                //     );
                                //     BaseController.decrementNotification();
                                //     setState(() {});
                                //     BaseController.persistentController
                                //         .jumpToTab(1);
                                //   } else
                                //     null;
                                // }
                              },
                              child: const DispatchCard_04(
                                  text:
                                      'Sandra',
                                  title:
                                      "Baols ",
                                  time:
                                      'Forte'),
                            ),
                            SizedBox(
                              height: DeviceUtils.getScaledHeight(context,
                                  scale: 0.012),
                            )
                          ],
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
}
