import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/ui/pages/payment/card_payment.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';

class LabDetails extends StatefulWidget {
  const LabDetails({Key? key}) : super(key: key);

  @override
  State<LabDetails> createState() => _LabDetailsState();
}

class _LabDetailsState extends State<LabDetails> {
  String _selectedValue = 'select gender';
  List<String> listOfValue = ['select gender', 'male', 'female'];

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  late PanelController specimenController;
  late PanelController homeHealthController;


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
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.04),
                  vertical: DeviceUtils.getScaledHeight(context, scale: 0.01)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Back',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor0),
                        textAlign: TextAlign.left,
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
                            width:
                                DeviceUtils.getScaledWidth(context, scale: 1),
                            height: DeviceUtils.getScaledHeight(context,
                                scale: 0.25),
                            decoration: const BoxDecoration(
                              color: AppColors.appPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              image: DecorationImage(
                                  image: AssetImage('assets/images/lab1.jpg'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ormeprazole Lab Intl',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor0),
                      ),
                    ),
                    Row(
                      children: const [
                        Text(
                          'Wuse - Abuja',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              fontFamily: 'Montserrat Bold',
                              color: AppColors.appColor3),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.star,
                          color: AppColors.appPrimaryColor,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '4.5 User Rating',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              fontFamily: 'Montserrat Bold',
                              color: AppColors.appPrimaryColor),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                    ),
                    const Text(
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy '
                      'eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. '
                      'At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,'
                      ' no sea takimata sanctus est Lorem ipsum dolor sit amet.',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          fontFamily: 'Montserrat Bold',
                          color: AppColors.appColor3),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Request Tests',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontFamily: 'Montserrat Bold',
                                color: AppColors.appColor0),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            specimenController.open();
                          },
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'View All Tests',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  fontFamily: 'Montserrat ExtraBold',
                                  color: AppColors.appPrimaryColor),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
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
                            contentPadding: const EdgeInsets.fromLTRB(
                                10.0, 10.0, 10.0, 10.0),
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: 'Montserrat Regular',
                                color: AppColors.appColor0),
                            counterText: "",
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 0, color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(10)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 0, color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 0),
                                borderRadius: BorderRadius.circular(10.0))),
                        hint: const Text(
                          '',
                        ),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value.toString();
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            _selectedValue = value.toString();
                          });
                        },
                        items: listOfValue.map((String val) {
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
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.medication,
                            color: AppColors.appPrimaryColor,
                          ),
                          SizedBox(
                            width: DeviceUtils.getScaledWidth(context,
                                scale: 0.03),
                          ),
                          const Text(
                            "Full Blood Count",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: 'Montserrat ExtraBold',
                                color: AppColors.appColor3),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.01),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.medication,
                            color: AppColors.appPrimaryColor,
                          ),
                          SizedBox(
                            width: DeviceUtils.getScaledWidth(context,
                                scale: 0.03),
                          ),
                          const Text(
                            "Malaria Test",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: 'Montserrat ExtraBold',
                                color: AppColors.appColor3),
                            textAlign: TextAlign.left,
                          ),
                        ],
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
                          homeHealthController.open();

                          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()));
                          // if(_formKey.currentState!.validate()){
                          //   // if ( await loginController
                          //   //     .loginUserAccount( name_field, password)) {
                          //   //   ToastWidget(
                          //   //       context, loginController.message.value, loginController.weight.value, 3);
                          //   //   _btnController.reset();
                          //   //   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
                          //   // } else {
                          //   //   ToastWidget(
                          //   //       context, loginController.message.value, loginController.weight.value, 3);
                          //   //   _btnController.reset();
                          //   // }
                          // }else _btnController.reset();
                        }),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.13),
                    ),
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
              panel: const TestList(),
              boxShadow: const [],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
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
              controller: homeHealthController,
              backdropOpacity: 0.2,
              backdropEnabled: true,
              color: AppColors.whiteColor,
              backdropTapClosesPanel: true,
              panel: ConfirmTest(),
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
  const TestList({Key? key}) : super(key: key);

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
          const Text(
            'Tests',
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
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.3, color: AppColors.appColor3),
                    ),
                  ),
                  child: const ListTile(
                      title: Text(
                        'Malaria Tests',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor3),
                        textAlign: TextAlign.left,
                      ),
                      trailing: Text(
                        'N500.00',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor3),
                        textAlign: TextAlign.center,
                      )),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 0.3, color: AppColors.appColor3),
                    ),
                  ),
                  child: const ListTile(
                      title: Text(
                        'Malaria Tests',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor3),
                        textAlign: TextAlign.left,
                      ),
                      trailing: Text(
                        'N500.00',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor3),
                        textAlign: TextAlign.center,
                      )),
                ),
                 
              ],
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



class ConfirmTest extends StatefulWidget {

   ConfirmTest({ Key? key}) : super(key: key);

  @override
  State<ConfirmTest> createState() => _ConfirmTestState();
}
class _ConfirmTestState extends State<ConfirmTest> {


  @override
  void initState() {
     super.initState();
  }

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
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 0.2, color: AppColors.appColor3),
                      ),
                    ),
                    child: const ListTile(
                        title: Text(
                          'Malaria Tests',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              fontFamily: 'Montserrat Bold',
                              color: AppColors.appColor3),
                          textAlign: TextAlign.left,
                        ),
                        trailing: Text(
                          'N500.00',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              fontFamily: 'Montserrat Bold',
                              color: AppColors.appColor3),
                          textAlign: TextAlign.center,
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, scale: 0.02),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Total Price",
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
            Transform.translate(
              offset: const Offset(14, 0),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'N3,500.00',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    fontFamily: 'Montserrat ExtraBold',
                    color: AppColors.appColor0,
                  ),
                  textAlign: TextAlign.left,
                ),
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
                    'Proceed to Pay',
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CardPayment()));
                  // if(_formKey.currentState!.validate()){
                  //   // if ( await loginController
                  //   //     .loginUserAccount( name_field, password)) {
                  //   //   ToastWidget(
                  //   //       context, loginController.message.value, loginController.weight.value, 3);
                  //   //   _btnController.reset();
                  //   //   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
                  //   // } else {
                  //   //   ToastWidget(
                  //   //       context, loginController.message.value, loginController.weight.value, 3);
                  //   //   _btnController.reset();
                  //   // }
                  // }else _btnController.reset();
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
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Login()));
                // if(_formKey.currentState!.validate()){
                //   // if ( await loginController
                //   //     .loginUserAccount( name_field, password)) {
                //   //   ToastWidget(
                //   //       context, loginController.message.value, loginController.weight.value, 3);
                //   //   _btnController.reset();
                //   //   // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
                //   // } else {
                //   //   ToastWidget(
                //   //       context, loginController.message.value, loginController.weight.value, 3);
                //   //   _btnController.reset();
                //   // }
                // }else _btnController.reset();
              }),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.04),
          ),
        ],
      ),

    );
  }
}
