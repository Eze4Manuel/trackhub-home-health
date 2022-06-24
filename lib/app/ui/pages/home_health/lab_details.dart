import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/dashboard_controller.dart';
import 'package:trackhub_home_health/app/ui/pages/payment/card_payment.dart';
import 'package:trackhub_home_health/app/ui/pages/requests/home_health_request.dart';
import 'package:trackhub_home_health/app/ui/pages/requests/request_one.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';

class LabDetails extends StatefulWidget {
  int index;
  LabDetails({required this.index, Key? key}) : super(key: key);

  @override
  State<LabDetails> createState() => _LabDetailsState();
}

class _LabDetailsState extends State<LabDetails> {

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late PanelController specimenController;
  late PanelController homeHealthController;
  final DashboardController dashboardController =
  Get.put(DashboardController());
  bool loading = false;
  List tests_price = [];

  @override
  void initState() {
    specimenController = PanelController();
    homeHealthController = PanelController();
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
              padding: EdgeInsets.symmetric(
                  vertical: DeviceUtils.getScaledHeight(context, scale: 0.01)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: DeviceUtils.getScaledWidth(context, scale: 0.04),
                          ),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: 'Montserrat Bold',
                                color: AppColors.appColor0),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                    ),
                    ClipRRect(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: DeviceUtils.getScaledWidth(
                                context,
                                scale: 1),
                            height:
                            DeviceUtils.getScaledHeight(
                                context,
                                scale: 0.26),
                            decoration: BoxDecoration(
                                color: AppColors
                                    .tertiaryColor,

                                image: BaseController
                                    .laboratories[
                                widget.index]
                                ['image_url'] ==
                                    null || BaseController
                                    .laboratories[
                                widget.index]
                                ['image_url'].toString().isEmpty
                                    ? const DecorationImage(
                                    image: AssetImage(
                                      'assets/images/lab1.jpg',
                                    ),
                                    fit: BoxFit.cover)
                                    : DecorationImage(
                                    image: NetworkImage(
                                        BaseController
                                            .laboratories[
                                        widget.index][
                                        'image_url'] ?? ''),
                                    fit: BoxFit.cover
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: DeviceUtils.getScaledWidth(context, scale: 0.04),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              BaseController.laboratories[widget.index]['company_name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  fontFamily: 'Montserrat ExtraBold',
                                  color: AppColors.appColor0),
                            ),
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  BaseController.laboratories[widget.index]['address'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat Bold',
                                      color: AppColors.appColor3),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),

                              Flexible(
                                fit: FlexFit.loose,
                                child: BaseController.laboratories[widget.index]['rating'] != null ? Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: AppColors.secondaryColor,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${BaseController.laboratories[widget.index]['rating']}  Rating' ,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          fontFamily: 'Montserrat Bold',
                                          color: AppColors.appPrimaryColor),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ): Container()
                              )
                            ],
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.mail_outline,
                                color: AppColors.secondaryColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: DeviceUtils.getScaledWidth(context, scale: 0.02),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  BaseController.laboratories[widget.index]['company_contact_email'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat Bold',
                                      color: AppColors.appColor3),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: AppColors.secondaryColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: DeviceUtils.getScaledWidth(context, scale: 0.02),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  BaseController.laboratories[widget.index]['company_contact_phone_number'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat Bold',
                                      color: AppColors.appColor3),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: AppColors.secondaryColor,
                                size: 20,
                              ),
                              SizedBox(
                                width: DeviceUtils.getScaledWidth(context, scale: 0.02),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  BaseController.laboratories[widget.index]['company_bio'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      fontFamily: 'Montserrat Bold',
                                      color: AppColors.appColor3),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () async {
                                setState((){
                                  loading = true;
                                });
                                if(await dashboardController.getTests()){
                                  setState((){
                                    loading = false;
                                    tests_price = BaseController.testPrices;
                                  });
                                  specimenController.open().whenComplete(() => setState((){}));

                                }else{
                                  setState((){
                                    loading = false;
                                  });
                                }
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: loading ?
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.secondaryColor,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                                    :
                                const Text(
                                  'View All Tests',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat Bold',
                                      color: AppColors.secondaryColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context, scale: 0.1),
                          ),
                          GestureDetector(
                            onTap: (){
                              homeHealthController.open();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(16)),
                                border: Border.all(width: 1, color: AppColors.appPrimaryColor)
                              ),
                              height: 45,
                              child:  const Center(
                                child: Text(
                                  'Request Home Care',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat Bold',
                                      color: AppColors.appPrimaryColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                          ),
                          RoundedLoadingButton(
                              controller: _btnController,
                              height: 45,
                              borderRadius: 16,
                              color: AppColors.appPrimaryColor,
                              successColor: AppColors.appPrimaryColor,
                              child: const Center(
                                child: Text(
                                  'Place Request',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      fontFamily: 'Montserrat Bold',
                                      color: AppColors.whiteColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              onPressed: () async {
                                BaseController.requestType = 'pickup';
                                _btnController.reset();
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const RequestOne()));

                              }),
                          SizedBox(
                            height: DeviceUtils.getScaledHeight(context, scale: 0.13),
                          ),
                        ]
                      ),
                    )
                  ],
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
              controller: specimenController,
              backdropOpacity: 0.2,
              backdropEnabled: true,
              color: AppColors.whiteColor,
              backdropTapClosesPanel: true,
              onPanelOpened: () {
                setState(() {});
              },
              panel: TestList(testPrices: tests_price),
              boxShadow: const [],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),

            SlidingUpPanel(
              maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.34),
              minHeight: DeviceUtils.getScaledHeight(context, scale: 0),
              padding: EdgeInsets.symmetric(
                  vertical: DeviceUtils.getScaledHeight(context, scale: 0.01),
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.02)),
              margin: EdgeInsets.only(
                  bottom: DeviceUtils.getScaledHeight(context, scale: 0.072)),
              controller: homeHealthController,
              backdropOpacity: 0.2,
              backdropEnabled: true,
              color: AppColors.whiteColor,
              backdropTapClosesPanel: true,
              panel: RequestHomeCare(),
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

class TestList extends StatelessWidget {
  List testPrices;
  TestList({required this.testPrices, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceUtils.getScaledHeight(context, scale: 0.45),
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.03),
          vertical: DeviceUtils.getScaledHeight(context, scale: 0.02)),
      child: Column(
        children: [
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.0),
          ),
          Container(
            width: DeviceUtils.getScaledWidth(context, scale: 0.1),
            height: 9,
            decoration: BoxDecoration(
              color: AppColors.color13,
              borderRadius: BorderRadius.circular(10)
            ),
            child: const Text(''),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tests',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: 'Montserrat ExtraBold',
                    color: AppColors.appColor0),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, scale: 0.01),
              ),
              Padding(
                padding: EdgeInsets.only(right: DeviceUtils.getScaledWidth(context, scale: 0.1)),
                child: const Text(
                  'Price',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: 'Montserrat ExtraBold',
                      color: AppColors.appColor0),
                    textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.02),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: BaseController.testPrices.length,
                itemBuilder: (context, index){
                  return Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.3, color: AppColors.appColor6),
                      ),
                    ),
                    child: ListTile(
                        leading: Text(
                          BaseController.testPrices[index]['name'],
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              fontFamily: 'Montserrat Bold',
                              color: AppColors.appColor3),
                          textAlign: TextAlign.left,
                        ),
                        trailing: Text(
                          'N${BaseController.testPrices[index]['price']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              fontFamily: 'Montserrat Bold',
                              color: AppColors.secondaryColor),
                          textAlign: TextAlign.center,
                        )),
                  );
                }

          ),


          ),

          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.04),
          ),
        ],
      ),
    );
  }
}



class RequestHomeCare extends StatefulWidget {

   RequestHomeCare({ Key? key}) : super(key: key);

  @override
  State<RequestHomeCare> createState() => _RequestHomeCareState();
}
class _RequestHomeCareState extends State<RequestHomeCare> {

  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();

  @override
  void initState() {
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.03),
          vertical: DeviceUtils.getScaledHeight(context, scale: 0.01)),
      child:  Column(
          children: [
            Container(
              width: DeviceUtils.getScaledWidth(context, scale: 0.1),
              height: 6,
              decoration: BoxDecoration(
                  color: AppColors.color13,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Text(''),
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.01),
            ),
            const Text(
              'Request Home Care',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontFamily: 'Montserrat Bold',
                  color: AppColors.appColor3),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.03),
            ),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "If you require health care delivered to you in your comfort area, Once a request is place, a varified home health agent will come to the location you specify as soon as possible",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.appColor0),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.03),
            ),

            RoundedLoadingButton(
                controller: _btnController,
                height: 45,
                borderRadius: 16,
                color: AppColors.appPrimaryColor,
                successColor: AppColors.appPrimaryColor,
                child: const Center(
                  child: Text(
                    'Proceed',
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
                  BaseController.requestType = 'home-health';
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeHealthRequest()));
                }),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.04),
            ),
          ],
        ),

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
      child:  Column(
        children: [
          Container(
            width: DeviceUtils.getScaledWidth(context, scale: 0.1),
            height: 9,
            decoration: BoxDecoration(
                color: AppColors.color13,
                borderRadius: BorderRadius.circular(10)
            ),
            child: const Text(''),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          const Text(
            'Request Summary',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: 'Montserrat Bold',
                color: AppColors.appColor3),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.03),
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
                  fontSize: 15,
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
              textAlign: TextAlign.left,
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

              }),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.04),
          ),
        ],
      ),

    );
  }
}
