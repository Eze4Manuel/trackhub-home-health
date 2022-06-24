import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/history_controller.dart';
import 'package:trackhub_home_health/app/ui/pages/history/active_history.dart';
import 'package:trackhub_home_health/app/ui/pages/history/fulfilled_history.dart';
import 'package:trackhub_home_health/app/ui/pages/history/pending_history.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'all_history.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
    getDispatches('');
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: Column(
            children: [
              Container(
                height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                width: DeviceUtils.getScaledWidth(context, scale: 0.89),
                margin: EdgeInsets.only(
                    top: DeviceUtils.getScaledHeight(context, scale: 0.08),
                    bottom: 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: AppColors.appColor4,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: TabBar(
                    labelColor: AppColors.whiteColor,
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'Montserrat ExtraBold',
                        color: AppColors.color12),
                    unselectedLabelColor: AppColors.color12,
                    isScrollable: true,
                    indicatorWeight: 2,
                    indicator: BoxDecoration(
                      color: AppColors.appPrimaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    indicatorColor: AppColors.appPrimaryColor,
                    tabs: const [
                      Tab(text: "All"),
                      Tab(text: "Pending"),
                      Tab(text: "Active"),
                      Tab(text: "Fulfilled"),
                    ],
                  ),
                ),
              ),
              Container(
                height: DeviceUtils.getScaledHeight(context, scale: 0.8),
                width: DeviceUtils.getScaledWidth(context, scale: 1),
                child: TabBarView(
                  children: [
                    loading
                        ? const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: AppColors.appPrimaryColor,
                              color: AppColors.whiteColor,
                              strokeWidth: 5,
                            ),
                          )
                        : const AllHistory(),
                    const PendingHistory(),
                    const ActiveHistory(),
                    const FulfilledHistory()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
