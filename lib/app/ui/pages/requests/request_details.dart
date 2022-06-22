import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/dashboard_controller.dart';
import 'package:trackhub_home_health/app/ui/pages/payment/card_payment.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';

class RequestDetail extends StatefulWidget {
  final int? orderLength;
  final Map<String, dynamic>? lab;
  final Map<String, dynamic>? selectedAddress;

  const RequestDetail(
      {this.orderLength, this.lab, this.selectedAddress, Key? key})
      : super(key: key);

  @override
  State<RequestDetail> createState() => _RequestDetailState();
}

class _RequestDetailState extends State<RequestDetail> {
  bool loading = false;
  bool submitting = false;
  double total = 0;
  DashboardController dashboardController = Get.put(DashboardController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime assignedDate = DateTime.now();
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: DeviceUtils.getScaledHeight(context, scale: 0.02),
            horizontal: DeviceUtils.getScaledWidth(context, scale: 0.06)),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.0),
              ),
              const Text(
                'Request details',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.appColor3),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.02),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.orderLength,
                itemBuilder: (context, index) {
                  return testBlock(context, index);
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
                  '${widget.lab!['company_name']}',
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
                  '${widget.lab!['address']}',
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
                  '${widget.selectedAddress!['address']}',
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
                      fontSize: 14,
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
                  '${1200}',
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
                  "Request Price",
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
                  'N ${BaseController.testOrders.isNotEmpty ? BaseController.testOrders.map((e) => double.parse(e['testPrices']['price'])).reduce((value, element) => value + element) + 1200 : 0}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 25,
                    fontFamily: 'Montserrat ExtraBold',
                    color: AppColors.appColor0,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.04),
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    submitting = true;
                  });
                  BaseController.totalCost = BaseController
                          .testOrders.isNotEmpty
                      ? BaseController.testOrders
                          .map((e) => double.parse(e['testPrices']['price']))
                          .reduce((value, element) => value + element)
                      : 0;
                  if (await dashboardController.pendingPayment()) {
                    setState(() {
                      submitting = false;
                    });
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(
                            builder: (context) => const CardPayment()))
                        .then((value) => {BaseController.testOrders.clear()});
                  }else{
                    setState((){
                      submitting = false;
                    });
                  }
                },
                child: Container(
                  width: DeviceUtils.getScaledWidth(context, scale: 0.8),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.appPrimaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.appPrimaryColor),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: submitting
                      ? const Center(
                          child: SizedBox(
                            width: 17,
                            height: 17,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        )
                      : const Text(
                          'Pay',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              fontFamily: 'Montserrat SemiBold',
                              color: AppColors.whiteColor),
                          textAlign: TextAlign.center,
                        ),
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.01),
              ),
              GestureDetector(
                onTap: () {
                  BaseController.testOrders.clear();
                  Navigator.pop(context);
                },
                child: Container(
                  width: DeviceUtils.getScaledWidth(context, scale: 0.8),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.appPrimaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whiteColor),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        fontFamily: 'Montserrat SemiBold',
                        color: AppColors.appPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget testBlock(context, index) {
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
            '${BaseController.testOrders[index]['name']}',
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
                "${BaseController.testOrders[index]['noOfBottles']} ",
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
                'Test(s)',
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
                ' - N ${BaseController.testOrders[index]['price']}',
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
        BaseController.testOrders[index]['moreInfo'].toString().isNotEmpty
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${BaseController.testOrders[index]['moreInfo']}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      fontFamily: 'Montserrat Bold',
                      color: AppColors.appColor3),
                  textAlign: TextAlign.left,
                ),
              )
            : Container(),
        SizedBox(
          height: DeviceUtils.getScaledHeight(context, scale: 0.01),
        ),
      ],
    ),
  );
}
