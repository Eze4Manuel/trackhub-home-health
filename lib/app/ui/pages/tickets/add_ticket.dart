import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/ticket_controller.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';

class AddTicket extends StatefulWidget {
  const AddTicket({Key? key}) : super(key: key);

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  final TicketController ticketController = Get.put(TicketController());
  final _formKey = GlobalKey<FormState>();

  String department = '';
  String subject = '';
  String message = '';

  bool loading = true;

  String _selectedValue = 'Select Department';
  List<dynamic> listOfValue = ['Select Department'];
  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();


  void getDepartments(String type) async {
    if (await ticketController.getDepartments(type)) {
      for (var element in BaseController.departments) {
        listOfValue.add(element['department_name']);
      }
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    getDepartments('');
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat ExtraBold',
                            color: AppColors.appColor0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Ticket',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            fontFamily: 'Montserrat ExtraBold',
                            color: AppColors.appColor0),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context, scale: 0.05),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: DropdownButtonFormField(
                    value: _selectedValue,
                    focusColor: AppColors.whiteColor,
                    icon: const Icon(Icons.keyboard_arrow_down_outlined),
                    decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Montserrat Regular',
                            color: AppColors.appColor0),
                        counterText: "",
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0, color: AppColors.whiteColor),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0, color: AppColors.whiteColor),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white, width: 0),
                            borderRadius: BorderRadius.circular(10.0))

                    ),
                    hint: !loading ? const Text(
                      'Select Ticket',
                      style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Montserrat Bold',
                          color: AppColors.color13
                      ),
                    ) :  const Text(
                      'Loading',
                      style: TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Montserrat Bold',
                          color: AppColors.color13
                      ),
                    ) ,
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value.toString();
                        department = value.toString();
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        _selectedValue = value.toString();
                      });
                    },
                    validator: (val){
                      if(val == "Select Department"){
                        return 'select department';
                      }
                      return null;
                    },
                    items: listOfValue.map((dynamic val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(
                          val,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Montserrat Bold',
                              color: AppColors.appColor0),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context,
                      scale: 0.04),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextFormField(
                    style: const TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Montserrat Bold',
                        color: AppColors.appColor0
                    ),
                    decoration:
                    InputDecorationValues02(hintText: "Subject"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Subject';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        subject = val.toString();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context,
                      scale: 0.01),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextFormField(
                    maxLines: 15,
                    maxLength: 500,
                    style: const TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Montserrat Bold',
                        color: AppColors.appColor0
                    ),
                    decoration:
                    InputDecorationValues02(hintText: "Enter Message Here"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter detailed description of issue';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        message = val.toString();
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(context,
                      scale: 0.16),
                ),
                RoundedLoadingButton(
                    controller: _btnController,
                    height: 45,
                    borderRadius: 15,
                    color: AppColors.appPrimaryColor,
                    successColor: AppColors.appPrimaryColor,
                    child: const Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.whiteColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        if ( await ticketController
                            .createTicket(department, subject, message)) {
                          ToastWidget(
                              context, ticketController.message.value, ticketController.weight.value, 3);
                           _btnController.reset();
                           Navigator.pop(context);
                        } else {
                          ToastWidget(
                              context, ticketController.message.value, ticketController.weight.value, 3);
                          _btnController.reset();
                        }
                      }else {
                        _btnController.reset();
                      }
                    }),
                SizedBox(
                  height: DeviceUtils.getScaledHeight(
                      context,
                      scale: 0.1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
