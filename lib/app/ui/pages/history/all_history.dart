import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/history_controller.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';
import 'dispatch_details.dart';


class AllHistory extends StatefulWidget {
  const AllHistory({Key? key}) : super(key: key);

  @override
  State<AllHistory> createState() => _HistoryState();
}

class _HistoryState extends State<AllHistory> {
  final HistoryController historyController = Get.put(HistoryController());

  bool loading = false;

  void getDispatches(String type) async {
    if (await historyController.getDispatches(type)) {
      if (BaseController.assignedDipatches != null) {
        setState(() {
          loading = false;
        });
      }
    }
  }
  void caller() {
    BaseController.persistentController.addListener(() {
      if (BaseController.persistentController.index == 1) {
        getDispatches('');
      }else{
      }
    });
  }
  @override
  void initState() {
    caller();
    getDispatches('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appColor5,
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: DeviceUtils.getScaledWidth(context, scale: 0.02),
              vertical: DeviceUtils.getScaledHeight(context, scale: 0.01)),
          child:
               ListView.builder(
                      itemCount: BaseController.dispatches.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                 DispatchDetails(index: index)))
                                    .then((value) => {setState(() {})});
                              },
                              child: DispatchCard_02(
                                  id: BaseController.dispatches[index]['_id'] ??
                                      '',
                                  title: BaseController.dispatches[index]['company_name'] ??
                                      '',
                                  pickup: BaseController.dispatches[index]
                                  ['pickup_address'] ??
                                      '',
                                  dropoff: BaseController.dispatches[index]
                                  ['dropoff_address'] ??
                                      '',
                                  panelColor: (BaseController.dispatches[index]
                                  ['dispatch_status'] ==
                                      'pending')
                                      ? AppColors.secondaryColor
                                      : (BaseController.dispatches[index]
                                  ['dispatch_status'] ==
                                      'fulfilled')
                                      ? AppColors.appColor2_1
                                      : (BaseController.dispatches[index]
                                  ['dispatch_status'] ==
                                      'active')
                                      ? AppColors.color8
                                      : AppColors.color7),
                            ),
                            SizedBox(
                              height: DeviceUtils.getScaledHeight(context,
                                  scale: 0.012),
                            )
                          ],
                        );
                      })

        ));
  }
}
