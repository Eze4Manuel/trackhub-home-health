import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/history_controller.dart';
import 'package:trackhub_home_health/app/ui/pages/history/dispatch_details.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';

class PendingHistory extends StatefulWidget {
  const PendingHistory({Key? key}) : super(key: key);

  @override
  State<PendingHistory> createState() => _HistoryState();
}

class _HistoryState extends State<PendingHistory> {
  final HistoryController historyController = Get.put(HistoryController());

  bool loading = true;

  void getDispatches(String type) async {
    if (await historyController.getDispatches(type)) {
      if (BaseController.assignedDipatches != null) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    getDispatches('pending');
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
          child: loading
              ? const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.appPrimaryColor,
                    color: AppColors.whiteColor,
                    strokeWidth: 5,
                  ),
                )
              : ListView.builder(
                  itemCount: BaseController.dispatches.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DispatchDetails(index: index))).then((value) => {setState(() {})});
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
                  }),
        ));
  }
}
