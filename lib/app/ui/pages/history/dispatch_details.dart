import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/history_controller.dart';
import 'package:trackhub_home_health/app/ui/pages/requests/phlebotomist_details.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';

import '../../../controller/dashboard_controller.dart';

class DispatchDetails extends StatefulWidget {
  int index;

  DispatchDetails({required this.index, Key? key}) : super(key: key);

  @override
  State<DispatchDetails> createState() => _DisplayDetailsState();
}

class _DisplayDetailsState extends State<DispatchDetails> {
  bool loading = false;
  double total = 0.00;
  late PanelController agentController;
  HistoryController historyController = Get.put(HistoryController());

  @override
  void initState() {
    agentController = PanelController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    total = BaseController.dispatches[widget.index]['payment_structure']['amount'].toDouble();

    final DateTime assignedDate = DateTime.now();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container( height: DeviceUtils.getScaledHeight(context, scale: 1),
              padding: EdgeInsets.symmetric(
                  vertical: DeviceUtils.getScaledHeight(context, scale: 0.02),
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.04)),
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Request Details',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                fontFamily: 'Montserrat ExtraBold',
                                color: AppColors.appColor0),
                            textAlign: TextAlign.left,
                          ),
                        ),

                        BaseController.dispatches[widget.index]['dispatcher_details']['assigned_time'] == null
                            ?
                        const Text(
                          'Pending',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              fontFamily: 'Montserrat ExtraBold',
                              color: AppColors.secondaryColor),
                          textAlign: TextAlign.left,
                        ):
                        GestureDetector(
                          onTap: () async {
                            setState((){
                              loading = true;
                            });
                            if(await historyController.getPhlebotomistDetail(BaseController.dispatches[widget.index]['dispatcher_details']['dispatcher_id'])){
                              setState((){
                                loading = false;
                              });
                              agentController.open();
                            }else{
                              setState((){
                                loading = false;
                              });
                            }
                          },
                          child: const Text(
                            'View Agent',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                fontFamily: 'Montserrat ExtraBold',
                                color: AppColors.color7),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${BaseController.dispatches[widget.index]['dropoff_name'].toString().capitalize }',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          fontFamily: 'Montserrat ExtraBold',
                          color: AppColors.appPrimaryColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    TimelineTile(
                      afterLineStyle:
                      const LineStyle(color: AppColors.secondaryColor, thickness: 1),
                      indicatorStyle: const IndicatorStyle(
                          drawGap: true, width: 5, color: AppColors.secondaryColor),
                      alignment: TimelineAlign.manual,
                      isFirst: true,
                      lineXY: 0.25,
                      endChild: Container(
                        margin: const EdgeInsets.only(bottom: 15.0, left: 5.0),
                        child: Text(
                          '${BaseController.dispatches[widget.index]['pickup_address'].toString().capitalize }',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.color12,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      startChild: Container(
                        margin: const EdgeInsets.only(bottom: 15.0, right: 5.0),
                        child:  const Text(
                          'Pick up',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontFamily: 'Montserrat SemiBold',
                            color: AppColors.color12,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                    TimelineTile(
                      beforeLineStyle:
                      const LineStyle(color: AppColors.secondaryColor, thickness: 1),
                      indicatorStyle:
                      const IndicatorStyle(width: 5, color: AppColors.secondaryColor),
                      alignment: TimelineAlign.manual,
                      isLast: true,
                      lineXY: 0.25,
                      endChild: Container(
                        margin: const EdgeInsets.only(top: 0.0, left: 5.0),
                        child: Text(
                          '${BaseController.dispatches[widget.index]['dropoff_address'].toString().capitalize }',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              fontFamily: 'Montserrat Bold',
                              color: AppColors.color12),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      startChild: Container(
                        margin: const EdgeInsets.only(top: 0.0, right: 5.0),
                        child: const Text(
                          'Drop-off ',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              fontFamily: 'Montserrat SemiBold',
                              color: AppColors.color12),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),

                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: BaseController.dispatches[widget.index]['request_details'].length,
                      itemBuilder: (context, index) {
                        return testBlock(context, widget.index, index);
                      },
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Laboratory Details",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${BaseController.dispatches[widget.index]['dropoff_name']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'Montserrat SemiBold',
                          color: AppColors.appPrimaryColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${BaseController.dispatches[widget.index]['dropoff_address']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'Montserrat SemiBold',
                          color: AppColors.appPrimaryColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Recipients Details",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${BaseController.dispatches[widget.index]['pickup_address']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'Montserrat SemiBold',
                          color: AppColors.appPrimaryColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Fee",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'N ${1200}',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'Montserrat SemiBold',
                          color: AppColors.appPrimaryColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.04),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Dispatch Price",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                    ),
                     Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'N ${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                          fontFamily: 'Montserrat ExtraBold',
                          color: AppColors.appPrimaryColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.07),
                    ),
                  ],
                ),
              ),
            ),
            SlidingUpPanel(
              maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.4),
              minHeight: DeviceUtils.getScaledHeight(context, scale: 0),
              padding: EdgeInsets.symmetric(
                  vertical: DeviceUtils.getScaledHeight(context, scale: 0.02),
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.03)),
              margin: EdgeInsets.only(
                  bottom: DeviceUtils.getScaledHeight(context, scale: 0.022)),
              controller: agentController,
              backdropOpacity: 0.2,
              backdropEnabled: true,
              color: AppColors.whiteColor,
              backdropTapClosesPanel: true,
              onPanelOpened: () {
                setState(() {});
              },
              panel: PhlebotomistDetails( index: widget.index),
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

Widget testBlock(context, widgetIndex, index) {
  return Container(
    decoration: const BoxDecoration(
        border:
        Border(bottom: BorderSide(width: 0.5, color: AppColors.color13))),
    child: Column(
      children: [
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.01),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '${BaseController.dispatches[widgetIndex]['request_details'][index]['test_type'].toString().capitalize}',
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: 'Montserrat Bold',
                color: AppColors.appPrimaryColor),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.01),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${BaseController.dispatches[widgetIndex]['request_details'][index]['no_of_bottles'].toString().isNotEmpty ?  BaseController.dispatches[widgetIndex]['request_details'][index]['no_of_bottles'] : 1} ",
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.appColor3),
                textAlign: TextAlign.left,
              ),
            ),
            const Flexible(
              child: Text(
                'Bottle(s)',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.appColor3),
                textAlign: TextAlign.left,
              ),
            ),
            Flexible(
              child: Text(
                ' - N ${BaseController.dispatches[widgetIndex]['request_details'][index]['price']}',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.appPrimaryColor),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.01),
        ),
         Align(
          alignment: Alignment.centerLeft,
          child: Text(
            BaseController.dispatches[widgetIndex]['request_details'][index]['more_info'].toString(),
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                fontFamily: 'Montserrat Bold',
                color: AppColors.appColor3),
            textAlign: TextAlign.left,
          ),
        ),

        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.01),
        ),
      ],
    ),
  );
}


