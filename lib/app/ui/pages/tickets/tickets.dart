import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/ui/pages/tickets/add_ticket.dart';
import 'package:trackhub_home_health/app/ui/pages/tickets/ticket_details.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';

import '../../../controller/ticket_controller.dart';

class Tickets extends StatefulWidget {
  const Tickets({Key? key}) : super(key: key);

  @override
  State<Tickets> createState() => _TicketsState();
}

class _TicketsState extends State<Tickets> {
  final TicketController ticketController = Get.put(TicketController());
  bool loading = true;

  void getTickets() async {
    if (await ticketController.getTickets()) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    getTickets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: DeviceUtils.getScaledHeight(context, scale: 1),
        color: AppColors.appColor4,
        padding: EdgeInsets.symmetric(
            vertical: DeviceUtils.getScaledHeight(context, scale: 0.03),
            horizontal: DeviceUtils.getScaledWidth(context, scale: 0.04)),
        child: Column(
          children: [
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.03),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ),
                ),
                const Text(
                  'Ticket',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      fontFamily: 'Montserrat ExtraBold',
                      color: AppColors.appColor0),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const AddTicket()));
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: 'Montserrat ExtraBold',
                        color: AppColors.appColor0 ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.02),
            ),
            loading
                ?  Container(
              height: DeviceUtils.getScaledHeight(context, scale: 0.8),
              child: const Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.appPrimaryColor,
                  color: AppColors.whiteColor,
                  strokeWidth: 5,
                ),
              ),
            )
                : Expanded(
                    child: ListView.builder(
                        itemCount: BaseController.tickets.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TicketDetails(index: index)));
                                },
                                child: DispatchCard_03(index: index),
                              ),
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context,
                                    scale: 0.012),
                              )
                            ],
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
