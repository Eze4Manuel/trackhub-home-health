
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/controller/authentication_controller.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../model/place_service.dart';
import '../../../utils/device_utils.dart';
import '../../../utils/widget_utils.dart';
import '../../theme/app_colors.dart';
import '../requests/address_setting.dart';

class AddressUpdate extends StatefulWidget {

  PanelController addressSearchController;
  AddressUpdate({required this.addressSearchController, Key? key}) : super(key: key);

  @override
  State<AddressUpdate> createState() => _AddressUpdateState();
}

class _AddressUpdateState extends State<AddressUpdate> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();
  final _controller = TextEditingController();
  final AuthenticationController authenticationController =
  Get.put(AuthenticationController());

  String address = '';

  @override
  Widget build(BuildContext context) {
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
              'Update Address',
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
                        'Address',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appPrimaryColor),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: AppColors.appColor4,
                        ),
                        child: TextFormField(
                          controller: _controller,

                          style: const TextStyle(
                              fontSize: 13.0,
                              fontFamily: 'Montserrat SemiBold',
                              color: AppColors.appColor0),
                          readOnly: true,
                          decoration: InputDecorationValues03(
                            hintText: BaseController.user_data['address'],
                            surfixIcon: const Icon(
                              Icons.my_location,
                              color: AppColors.appPrimaryColor,
                              size: 25,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isNotEmpty &&
                                value.length < 3) {
                              return 'Address not set';
                            }
                            return null;
                          },
                          onTap: () async {
                            final sessionToken = const Uuid().v4();
                            final Suggestions? result =
                            await showSearch(
                              context: context,
                              delegate: AddressSearch(sessionToken),
                            );
                            // This will change the text displayed in the TextField
                            if (result != null) {
                              final placeDetails =
                              await PlaceApiProvider(
                                  sessionToken)
                                  .getPlaceDetailFromId(
                                  result.placeId);
                              setState(() {
                                _controller.text =
                                    result.description;
                                address = result.description;
                              });
                            }
                          },
                          // onChanged: (val) {
                          //   setState(() {});
                          // },
                        ),
                      ),
                      SizedBox(
                        height: DeviceUtils.getScaledHeight(context,
                            scale: 0.03),
                      ),
                      address.isNotEmpty
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
                            if (await authenticationController
                                .updateAddress(
                                BaseController.user_data['email'],
                                address,
                                AuthenticationController
                                    .addressInfo)) {
                              ToastWidget(
                                  context,
                                  authenticationController
                                      .message.value,
                                  authenticationController
                                      .weight.value,
                                  3);
                              widget.addressSearchController.close();
                              _btnController.reset();

                            } else {
                              ToastWidget(
                                  context,
                                  authenticationController
                                      .message.value,
                                  authenticationController
                                      .weight.value,
                                  3);
                              _btnController.reset();
                            }
                          })
                          : const Text(
                        'Select your address or a landmark close to you to proceed',
                        style: TextStyle(
                            fontSize: 13.0,
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
