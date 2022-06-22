import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/dashboard_controller.dart';
import 'package:trackhub_home_health/app/model/debit_card.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';

class CardPayment extends StatefulWidget {
  const CardPayment({Key? key}) : super(key: key);

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late PanelController successController;
  DashboardController dashboardController = Get.put(DashboardController());

  TextEditingController textControllerCardName = TextEditingController();
  TextEditingController textControllerCardNumber = TextEditingController();
  TextEditingController textControllerCardMonth = TextEditingController();
  TextEditingController textControllerCardYear = TextEditingController();
  TextEditingController textControllerCardCCV = TextEditingController();


  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();

  DebitCard debitCard = DebitCard();

  @override
  void initState() {
    successController = PanelController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Builder(
        builder: (context) => Stack(
          children: [
            Container(
              width: DeviceUtils.getScaledWidth(context, scale: 1),
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.05)),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.03),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Back',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: 'Montserrat ExtraBold',
                                color: AppColors.appColor3),
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.04),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Card Details',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              fontFamily: 'Montserrat ExtraBold',
                              color: AppColors.appColor0),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.02),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextFormField(
                          controller: textControllerCardName,
                          style: const TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Montserrat SemiBold',
                              color: AppColors.appColor0),
                          decoration:
                              InputDecorationValues02(hintText: 'Card Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Card Name required';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              debitCard.card_name = val.toString();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.02),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextFormField(
                          controller: textControllerCardNumber,
                          maxLength: 16,
                          style: const TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Montserrat SemiBold',
                              color: AppColors.appColor0),
                          decoration:
                              InputDecorationValues02(hintText: 'Card Number'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Card Number required';
                            }
                            if (value!.isNotEmpty && value.length != 16) {
                              return 'Incorrect details';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              debitCard.card_number = val.toString();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.02),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: TextFormField(
                                controller: textControllerCardMonth,
                                maxLength: 2,
                                style: const TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: 'Montserrat SemiBold',
                                    color: AppColors.appColor0),
                                decoration:
                                    InputDecorationValues02(hintText: 'MM'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'required';
                                  }
                                  if (value!.isNotEmpty && value.length != 2) {
                                    return 'Invalid detail';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    debitCard.month = val.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: DeviceUtils.getScaledWidth(context,
                                scale: 0.03),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: TextFormField(
                                controller: textControllerCardYear,
                                maxLength: 2,
                                style: const TextStyle(
                                    fontSize: 13.0,
                                    fontFamily: 'Montserrat SemiBold',
                                    color: AppColors.appColor0),
                                decoration:
                                    InputDecorationValues02(hintText: 'YY'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'required';
                                  }
                                  if (value!.isNotEmpty && value.length != 2) {
                                    return 'Invalid';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    debitCard.year = val.toString();
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.02),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: TextFormField(
                          controller: textControllerCardCCV,
                          maxLength: 3,
                          style: const TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Montserrat SemiBold',
                              color: AppColors.appColor0),
                          decoration: InputDecorationValues02(hintText: 'CCV'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'required';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              debitCard.ccv = val.toString();
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.03),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseController.user_data['card_details'] != null
                              ? GestureDetector(
                                  onTap: () {
                                    textControllerCardName.text = BaseController.user_data['card_details']['card_name'];
                                    textControllerCardNumber.text = BaseController.user_data['card_details']['card_number'];
                                    textControllerCardMonth.text = BaseController.user_data['card_details']['month'];
                                    textControllerCardYear.text = BaseController.user_data['card_details']['year'];
                                    textControllerCardCCV.text = BaseController.user_data['card_details']['ccv'];
                                    setState((){
                                      debitCard.card_name = BaseController.user_data['card_details']['card_name'];
                                      debitCard.card_number = BaseController.user_data['card_details']['card_name'];
                                      debitCard.month = BaseController.user_data['card_details']['month'];
                                      debitCard.year = BaseController.user_data['card_details']['year'];
                                      debitCard.ccv = BaseController.user_data['card_details']['ccv'];
                                    });
                                  },
                                  child: const Text(
                                    'Use Default',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Montserrat SemiBold',
                                        color: AppColors.appColor0),
                                  ),
                                )
                              : Container(),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isChecked = !isChecked!;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  'Save as new Default',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: 'Montserrat SemiBold',
                                      color: AppColors.appColor0),
                                ),
                                Transform.scale(
                                  scaleX: 0.7,
                                  scaleY: 0.7,
                                  child: Checkbox(
                                    activeColor: AppColors.appPrimaryColor,
                                    checkColor: AppColors.whiteColor,
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.07),
                      ),
                      RoundedLoadingButton(
                          controller: _btnController,
                          height: 45,
                          borderRadius: 16,
                          color: AppColors.appPrimaryColor,
                          successColor: AppColors.appPrimaryColor,
                          child: const Center(
                            child: Text(
                              'Pay',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat Bold',
                                  color: AppColors.whiteColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onPressed: () async {
                            _btnController.reset();

                            if (_formKey.currentState!.validate()) {
                              if (await dashboardController.paymentMadeUpdate(
                                  debitCard, isChecked)) {
                                ToastWidget(
                                    context,
                                    dashboardController.message.value,
                                    dashboardController.weight.value,
                                    3);
                                _btnController.reset();
                                successController.open();
                              } else {
                                ToastWidget(
                                    context,
                                    dashboardController.message.value,
                                    dashboardController.weight.value,
                                    3);
                                _btnController.reset();
                              }
                            } else {
                              _btnController.reset();
                            }
                          }),
                      SizedBox(
                        height:
                            DeviceUtils.getScaledHeight(context, scale: 0.08),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SlidingUpPanel(
              maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.45),
              minHeight: DeviceUtils.getScaledHeight(context, scale: 0),
              padding: EdgeInsets.symmetric(
                  vertical: DeviceUtils.getScaledHeight(context, scale: 0.01),
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.02)),
              margin: EdgeInsets.only(
                  bottom: DeviceUtils.getScaledHeight(context, scale: 0.072)),
              controller: successController,
              backdropOpacity: 0.6,
              backdropEnabled: true,
              color: AppColors.whiteColor,
              backdropTapClosesPanel: true,
              panel: const Successful(),
              boxShadow: const [],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class Successful extends StatefulWidget {
  const Successful({Key? key}) : super(key: key);

  @override
  State<Successful> createState() => _SuccessfulState();
}

class _SuccessfulState extends State<Successful> {
  @override
  Widget build(BuildContext context) {
    final RoundedLoadingButtonController _btnController =
        RoundedLoadingButtonController();

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.03),
          vertical: DeviceUtils.getScaledHeight(context, scale: 0.02)),
      child: Column(
        children: [
          Container(
            width: DeviceUtils.getScaledWidth(context, scale: 0.1),
            height: 9,
            decoration: BoxDecoration(
                color: AppColors.color13,
                borderRadius: BorderRadius.circular(10)),
            child: const Text(''),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.03),
          ),
          Image.asset(
            'assets/images/check.png',
            width: DeviceUtils.getScaledWidth(context, scale: 0.6),
            height: DeviceUtils.getScaledHeight(context, scale: 0.1),
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.02),
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Successful",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  fontFamily: 'Montserrat Bold',
                  color: AppColors.appColor0),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Payment received successfully, A phlebotomist will be sent shortly',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                fontFamily: 'Montserrat Bold',
                color: AppColors.appColor0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.04),
          ),
          RoundedLoadingButton(
              controller: _btnController,
              height: 45,
              borderRadius: 16,
              color: AppColors.appPrimaryColor,
              successColor: AppColors.appPrimaryColor,
              child: const Center(
                child: Text(
                  'Done',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: 'Montserrat Bold',
                      color: AppColors.whiteColor),
                  textAlign: TextAlign.center,
                ),
              ),
              onPressed: () async {
                _btnController.reset();
                Navigator.pop(context);

              }),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.04),
          ),
        ],
      ),
    );
  }
}
