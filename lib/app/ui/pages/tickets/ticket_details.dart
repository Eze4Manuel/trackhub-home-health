import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/ticket_controller.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class TicketDetails extends StatefulWidget {
  int index;

  TicketDetails({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<TicketDetails> createState() => _DisplayDetailsState();
}

class _DisplayDetailsState extends State<TicketDetails> {
  final TicketController ticketController = Get.put(TicketController());
  late PanelController specimenController;
  late TextEditingController textController =  TextEditingController();

  bool loading = true;
  String message = '';
  bool visible = false;

  void getSingleTicket() async {
    if (await ticketController
        .getSingleTicket(BaseController.tickets[widget.index]['_id'])) {
      if (BaseController.tickets != null) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  void initState() {
    specimenController = PanelController();
    getSingleTicket();
    KeyboardVisibilityController().onChange.listen((isVisible) {
      isVisible ? setState((){
        visible = true;
      }) : visible = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: AppColors.appColor4,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: DeviceUtils.getScaledHeight(context, scale: 0.02),
                left: DeviceUtils.getScaledWidth(context, scale: 0.04),
                right: DeviceUtils.getScaledWidth(context, scale: 0.04),
                bottom: visible ? DeviceUtils.getScaledHeight(context, scale: 0.09) : DeviceUtils.getScaledHeight(context, scale: 0.16),
            ),
            height: DeviceUtils.getScaledHeight(context, scale: 1),
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                  ),
                  Align(
                    child: GestureDetector(
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
                        textAlign: TextAlign.left,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                  ),
                  Text(
                    'ID ${BaseController.tickets[widget.index]['_id'].toString().substring(BaseController.tickets[widget.index]['_id'].toString().length - 7)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        fontFamily: 'Montserrat Bold',
                        color: AppColors.color12),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context, scale: 0.0),
                  ),
                  Container(
                    width: DeviceUtils.getScaledWidth(context, scale: 1),
                    padding: EdgeInsets.symmetric(
                      vertical:
                      DeviceUtils.getScaledHeight(context, scale: 0.03),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.appColor4),
                    child: loading
                        ? SizedBox(
                      height: DeviceUtils.getScaledHeight(context,
                          scale: 0.6),
                      child: const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: AppColors.appPrimaryColor,
                          color: AppColors.whiteColor,
                          strokeWidth: 5,
                        ),
                      ),
                    )
                        :
                    ListView.builder(
                        itemCount: BaseController
                            .selectedTicket['comments'].length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              BaseController.selectedTicket['comments'][index]['messenger_id'] == BaseController.user_data['_id'] ?
                              DispatchCard_07(
                                  comment: BaseController
                                      .selectedTicket['comments'][index])
                                  :
                              DispatchCard_06(
                                  comment: BaseController
                                      .selectedTicket['comments'][index]),
                              SizedBox(
                                height: DeviceUtils.getScaledHeight(context,
                                    scale: 0.012),
                              )
                            ],
                          );
                        }
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: visible ? DeviceUtils.getScaledHeight(context, scale: 0.0) : DeviceUtils.getScaledHeight(context, scale: 0.08),
              child: Container(
                color: AppColors.tertiaryColor,
                padding: EdgeInsets.symmetric(
                    vertical: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    horizontal: DeviceUtils.getScaledWidth(context, scale: 0.06)),
                child: Row(
                  children: [
                    Container(
                      width: DeviceUtils.getScaledWidth(context, scale: 0.7),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),

                      child: TextFormField(
                        controller: textController,
                        minLines: 1,
                        maxLines: 5,
                        style: const TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor0),
                        decoration:
                        InputDecorationValues02(hintText: "Subject"),
                        onChanged: (val) {
                          setState(() {
                            message = val.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: DeviceUtils.getScaledWidth(context, scale: 0.03),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.appPrimaryColor),
                        child: Transform.rotate(
                          angle: 25,
                          child: IconButton(
                            onPressed: () async {
                              if (message.length > 0) {
                                   if (await ticketController.sendComment(
                                      message, BaseController.selectedTicket['_id'], BaseController.selectedTicket['comments'].length == 0 ?  BaseController.selectedTicket['_id'] : BaseController.selectedTicket['comments'][BaseController.selectedTicket['comments'].length -1]['messenger_id'])) {
                                    ToastWidget(
                                        context,
                                        ticketController.message.value,
                                        ticketController.weight.value,
                                        3);
                                    Navigator.pop(context);
                                  } else {
                                    ToastWidget(
                                        context,
                                        ticketController.message.value,
                                        ticketController.weight.value,
                                        3);
                                  }
                              }
                            },
                            padding: const EdgeInsets.all(1),
                            iconSize: 25,
                            icon: const Icon(Icons.send),
                            color: AppColors.whiteColor,
                          ),
                        ))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
