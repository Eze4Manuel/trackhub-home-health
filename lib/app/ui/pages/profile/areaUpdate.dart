
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:searchfield/searchfield.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/controller/authentication_controller.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/profile_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../model/place_service.dart';
import '../../../model/test.dart';
import '../../../utils/device_utils.dart';
import '../../../utils/widget_utils.dart';
import '../../theme/app_colors.dart';
import '../requests/address_setting.dart';

class AreaUpdate extends StatefulWidget {

  PanelController areaUpdateController;
  AreaUpdate({required this.areaUpdateController, Key? key}) : super(key: key);

  @override
  State<AreaUpdate> createState() => _AreaUpdateState();
}

class _AreaUpdateState extends State<AreaUpdate> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();
  final _controller = TextEditingController();

  final TextEditingController _testNameTextFieldController =
  TextEditingController();

  final ProfileController profileController =
  Get.put(ProfileController());

  String address = '';
  var listOfAreas = [];
  bool seggestionTap = false;
  bool testLoading = false;
  String area = '';

  Future<void> fetchListOfAreas( ) async {

    // Gets the list of test for the selected lab
    if (await profileController.getListOfAreas()) {
      listOfAreas.clear();
      for (var element in BaseController.areaLists) {
        listOfAreas.add(element['name']);
      }
      setState(() {
        testLoading = false;
      });
    }
  }


  @override
  void initState() {

    fetchListOfAreas();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(BaseController.user_data);
    return  Padding(
      padding: EdgeInsets.symmetric(
          vertical:
          DeviceUtils.getScaledHeight(context, scale: 0.0),
          horizontal:
          DeviceUtils.getScaledWidth(context, scale: 0.07)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: DeviceUtils.getScaledHeight(context,
                    scale: 0.02)),
            const Text(
              'Update Area',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  fontFamily: 'Montserrat ExtraBold',
                  color: AppColors.appPrimaryColor),
            ),
            SizedBox(
                height: DeviceUtils.getScaledHeight(context,
                    scale: 0.03)),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Area',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appPrimaryColor),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: SearchField(
                            controller: _testNameTextFieldController,
                            suggestions: listOfAreas
                                .map((e) => SearchFieldListItem(e))
                                .toList(),
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
                            onSuggestionTap: (x) {
                              setState(() {
                                seggestionTap = true;
                                area =
                                    _testNameTextFieldController.value.text;
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
                            hint: 'Select Area',
                            hasOverlay: true,
                            searchStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                fontFamily: 'Montserrat Bold',
                                color: AppColors.appColor0),
                          )),
                      SizedBox(
                        height: DeviceUtils.getScaledHeight(context,
                            scale: 0.03),
                      ),
                      area.isNotEmpty
                          ? RoundedLoadingButton(
                          controller: _btnController,
                          disabledColor: AppColors.appColor3,
                          height: 45,
                          borderRadius: 16,
                          color: AppColors.appPrimaryColor,
                          successColor:
                          AppColors.appPrimaryColor,
                          child: const Center(
                            child: Text(
                              'Update',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  fontFamily: 'Montserrat Bold',
                                  color: AppColors.whiteColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onPressed: () async {
                            if (await profileController
                                .updateArea(area)) {
                              ToastWidget(
                                  context,
                                  profileController
                                      .message.value,
                                  profileController
                                      .weight.value,
                                  3);
                              widget.areaUpdateController.close();
                              _btnController.reset();
                            } else {
                              ToastWidget(
                                  context,
                                  profileController
                                      .message.value,
                                  profileController
                                      .weight.value,
                                  3);
                              _btnController.reset();
                            }
                          })
                          : const Text(
                        'Select your address area from the list of areas available',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Montserrat SemiBold',
                            color: AppColors.appPrimaryColor),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: DeviceUtils.getScaledHeight(context,
                            scale: 0.02),
                      ),
                      SizedBox(
                        height: DeviceUtils.getScaledHeight(context,
                            scale: 0.02),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
