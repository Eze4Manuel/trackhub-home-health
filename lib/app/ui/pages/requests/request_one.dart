import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/dashboard_controller.dart';
import 'package:trackhub_home_health/app/model/test.dart';
import 'package:trackhub_home_health/app/ui/pages/requests/address_setting.dart';
import 'package:trackhub_home_health/app/ui/pages/requests/request_details.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';
import 'package:searchfield/searchfield.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RequestOne extends StatefulWidget {
  const RequestOne({Key? key}) : super(key: key);

  @override
  State<RequestOne> createState() => _RequestOneState();
}

class _RequestOneState extends State<RequestOne> {
  String _selectedValue = 'Select Lab';
  List<String> listOfValue = ['Select Lab'];
  Test testRequest = Test();
  var listOfTests = [];

  bool loading = true;
  bool enabled = false;
  bool testLoading = false;
  bool seggestionTap = false;
  String? test;

  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();
  late PanelController specimenController;
  late PanelController addressController;
  final TextEditingController _testNameTextFieldController =
  TextEditingController();
  final TextEditingController _testBottleNoTextFieldController =
  TextEditingController();
  final TextEditingController _testMoreInfoTextFieldController =
  TextEditingController();

  DashboardController dashboardController = Get.put(DashboardController());

  Future<void> fetchLabProviders() async {
    if (await dashboardController.getLabs()) {
      for (var element in BaseController.laboratories) {
        listOfValue.add(element['company_name']);
      }
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> fetchLabTests(value) async {
    // checks the fetched lab and filters out the seleceted lab
    BaseController.selectedLab = BaseController.laboratories
        .firstWhere((element) => element['company_name'] == value.toString());

    setState(() {
      _selectedValue = value.toString();
      testLoading = true;
      enabled = true;
    });
    // Gets the list of test for the selected lab
    if (await dashboardController.getTests()) {
      listOfTests.clear();
      for (var element in BaseController.testPrices) {
        listOfTests.add(element['name']);
      }
      setState(() {
        testLoading = false;
      });
    }
  }

  @override
  void initState() {
    specimenController = PanelController();
    addressController = PanelController();
    fetchLabProviders();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.appColor6,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: DeviceUtils.getScaledWidth(context, scale: 1),
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.05)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                                color: AppColors.appColor3),
                          ),
                        ),
                        Expanded(
                            child: Transform.translate(
                              offset: const Offset(-20, 0),
                              child: const Center(
                                  child: Text(
                                    'Pickup',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        fontFamily: 'Montserrat Bold',
                                        color: AppColors.appColor3),
                                    textAlign: TextAlign.left,
                                  )),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.03),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(
                          Icons.directions_bike_outlined,
                          size: 25,
                          color: AppColors.appPrimaryColor,
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 2,
                            // thickness of the line
                            indent: 10,
                            // empty space to the leading edge of divider.
                            endIndent: 10,
                            // empty space to the trailing edge of the divider.
                            color: AppColors.secondaryColor,
                            // The color to use when painting the line.
                            height: 10, // The divider's height extent.
                          ),
                        ),
                        Icon(
                          Icons.adjust,
                          size: 30,
                          color: AppColors.secondaryColor,
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 2,
                            // thickness of the line
                            indent: 10,
                            // empty space to the leading edge of divider.
                            endIndent: 10,
                            // empty space to the trailing edge of the divider.
                            color: AppColors.color13,
                            // The color to use when painting the line.
                            height: 10, // The divider's height extent.
                          ),
                        ),
                        Icon(
                          Icons.adjust,
                          size: 30,
                          color: AppColors.color13,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Order pickup of test samples or other items',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor3),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select Lab',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    IgnorePointer(
                      ignoring: enabled,
                      child: Container(
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
                            fetchLabTests(value);
                            _testNameTextFieldController.text = '';
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
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.06),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Specimen Details',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: SearchField(
                          controller: _testNameTextFieldController,
                          suggestions: enabled
                              ? listOfTests
                              .map((e) => SearchFieldListItem(e))
                              .toList()
                              : [],
                          searchInputDecoration: InputDecoration(
                              isDense: true,
                              suffixIcon: testLoading
                                  ? const SizedBox(
                                width: 0,
                                child: SpinKitRotatingCircle(
                                  color: AppColors.color13,
                                  size: 20.0,
                                ),
                              )
                                  : Container(
                                width: 0,
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(
                                  10.0, 0.0, 10.0, 0.0),
                              hintStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: 'Montserrat Bold',
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
                          maxSuggestionsInViewPort: 6,
                          itemHeight: 50,
                          inputType: !enabled ? TextInputType.none : null,
                          onSuggestionTap: (x) {
                            setState(() {
                              seggestionTap = true;
                              testRequest.name =
                                  _testNameTextFieldController.value.text;
                              testRequest.testPrices =
                                  BaseController.testPrices.firstWhere((
                                      element) =>
                                  element['name'] ==
                                      _testNameTextFieldController.value.text);
                              testRequest.price =
                              testRequest.testPrices!['price'];
                            });
                          },
                          validator: (x) {
                            if (x!.isEmpty) {
                              return 'Please select a test';
                            }
                            return null;
                          },
                          suggestionState: Suggestion.expand,
                          textInputAction: TextInputAction.none,
                          hint: enabled
                              ? 'Select Test'
                              : 'First choose Lab above',
                          hasOverlay: true,
                          searchStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                              fontFamily: 'Montserrat Bold',
                              color: AppColors.appColor0),
                        )),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.whiteColor,
                      ),
                      child: TextFormField(
                        controller: _testBottleNoTextFieldController,
                        style: const TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Montserrat SemiBold',
                            color: AppColors.appColor0),
                        decoration:
                        InputDecorationValues02(hintText: 'No of bottles'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isNotEmpty && value.length < 3) {
                            return 'Name too short';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            testRequest.noOfBottles = val.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.whiteColor,
                      ),
                      child: TextFormField(
                        controller: _testMoreInfoTextFieldController,
                        maxLines: 5,
                        style: const TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Montserrat SemiBold',
                            color: AppColors.appColor0),
                        decoration:
                        InputDecorationValues02(hintText: 'More Info'),
                        validator: (value) {
                          if (value!.isNotEmpty && value.length < 3) {
                            return 'Name too short';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            testRequest.moreInfo = val.toString();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.02),
                    ),
                    GestureDetector(
                      onTap: () {
                        seggestionTap ? {
                        BaseController.testOrders.add(testRequest.toJson()),
                        _testNameTextFieldController.text = '',
                        _testBottleNoTextFieldController.text = '',
                        _testMoreInfoTextFieldController.text = '',
                      }: {
                        ToastWidget(
                        context, "Test selected not offered by lab", 'danger', 3)
                        };
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              color: AppColors.appPrimaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text('Add Test',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Montserrat SemiBold',
                                  color: AppColors.whiteColor)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.05),
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
                          FocusManager.instance.primaryFocus?.unfocus();
                          BaseController.getSelectedLab();
                          BaseController.testOrders.isNotEmpty
                              ? {
                            setState(() {}),
                            addressController.open(),
                          }
                              : {
                            ToastWidget(
                                context, "No test added", 'danger', 3)
                          };
                        }),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context, scale: 0.13),
                    ),
                  ],
                ),
              ),
            ),
            SlidingUpPanel(
              maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.29),
              minHeight: DeviceUtils.getScaledHeight(context, scale: 0),
              padding: EdgeInsets.symmetric(
                  vertical: DeviceUtils.getScaledHeight(context, scale: 0.0),
                  horizontal: DeviceUtils.getScaledWidth(context, scale: 0.0)),
              margin: EdgeInsets.only(
                  bottom: DeviceUtils.getScaledHeight(context, scale: 0.072)),
              controller: addressController,
              backdropOpacity: 0.2,
              backdropEnabled: true,
              color: AppColors.whiteColor,
              backdropTapClosesPanel: true,
              panel: AddressSetting(
                  specimenController: specimenController,
                  addressController: addressController),
              boxShadow: const [],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            SlidingUpPanel(
              maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.8),
              minHeight: DeviceUtils.getScaledHeight(context, scale: 0),
              padding: EdgeInsets.symmetric(
                  vertical: DeviceUtils.getScaledHeight(context, scale: 0.02),
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
              panel: RequestDetail(
                orderLength: BaseController.getTestOrderLength(),
                lab: BaseController.selectedLab ?? {},
                selectedAddress: BaseController.getSelectedAddress() ?? {},),
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
