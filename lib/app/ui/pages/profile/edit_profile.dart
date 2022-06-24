import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:intl/intl.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/controller/profile_controller.dart';
import 'package:trackhub_home_health/app/ui/pages/profile/profile.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/device_utils.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';
import '../../../model/account.dart';


class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String _selectedValue =  'select gender';
  List<String> listOfValue = [ 'select gender', 'male', 'female'];

  final _formKey = GlobalKey<FormState>();
  // Phone field variables
  final TextEditingController _textController = TextEditingController();
  final String initialCountry = 'NG';
  final PhoneNumber number = PhoneNumber( phoneNumber: BaseController.user_data['phone_number'], isoCode: 'NG');

  final ProfileController profileController = Get.put(ProfileController());

  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();
  late PanelController _controller;
  TextEditingController dateCtl = TextEditingController();

  Account account = Account.profileUpdate(
    first_name: BaseController.user_data['first_name'],
    last_name: BaseController.user_data['last_name'],
    username: BaseController.user_data['username'],
    phone_number: BaseController.user_data['phone_number'],
    gender: BaseController.user_data['gender'],
    dob: BaseController.user_data['dob'],
  );
  bool valid = false;

  var imagePicker;
  bool loading = false;
  var _image;


  @override
  void initState() {
    _controller = PanelController();
    imagePicker = ImagePicker();

    super.initState();
  }




  // getting image stored
  Future<bool> getImage(type) async {
    var source = type == ImageSourceType.camera
        ? ImageSource.camera
        : ImageSource.gallery;
    XFile image = await imagePicker.pickImage(
        source: source,
        imageQuality: 50,
        preferredCameraDevice: CameraDevice.front);
    // setting the loading screen
    setState(() {
      loading = true;
    });
    if (await profileController.asyncFileUpload(
        "Profile Image", File(image.path))) {
      setState(() {
        _image = File(image.path);
        loading = false;
      });
      return true;

    } else {
      setState(() {
        loading = false;
      });
      return false;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          Container(
            height: DeviceUtils.getScaledHeight(context, scale: 1),
            color: AppColors.appColor4,
            padding: EdgeInsets.symmetric(
                vertical: DeviceUtils.getScaledHeight(context, scale: 0.03),
                horizontal: DeviceUtils.getScaledWidth(context, scale: 0.04)
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context,
                          scale: 0.03),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context,
                          scale: 0.02),
                    ),
                    const Center(
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                            fontWeight:
                            FontWeight.w400,
                            fontSize: 16,
                            fontFamily:
                            'Montserrat ExtraBold',
                            color: AppColors
                                .appColor0),
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context,
                          scale: 0.02),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if(await getImage(ImageSourceType.camera)){
                          ToastWidget(
                              context,
                              'Image upload complete',
                              'success',
                              3);
                        }
                      },
                      child: Stack(
                        children: [
                          Container(
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(108.0),
                                child: BaseController.user_data['image_url']
                                    .toString()
                                    .isEmpty ?
                                Image.asset(
                                  'assets/images/profile.png',
                                  height: 100.0,
                                  width: 100.0,
                                  color: AppColors.tertiaryColor,
                                ) :
                                Container(
                                  color: AppColors.tertiaryColor,
                                  child: Image.network(
                                    BaseController.user_data['image_url'],
                                    height: 100.0,
                                    width: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              ),
                            ),
                          ),
                          !loading ? const Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                  child:
                                  Icon(Icons.add_a_photo_outlined, color: AppColors.whiteColor, size: 30,)
                              )
                          )
                              :
                          const Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.tertiaryColor,
                                backgroundColor: AppColors.whiteColor,

                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context,
                          scale: 0.04),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'First Name',
                        style: TextStyle(
                            fontWeight:
                            FontWeight.w400,
                            fontSize: 13,
                            fontFamily:
                            'Montserrat Bold',
                            color: AppColors
                                .appColor0),
                        textAlign: TextAlign.start,
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
                        initialValue:  BaseController.user_data['first_name'],
                        style: const TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Montserrat SemiBold',
                            color: AppColors.appColor0
                        ),
                        decoration:
                        InputDecorationValues02(hintText: BaseController.user_data['first_name']),

                        onChanged: (val) {
                          setState(() {
                            account.first_name = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context,
                          scale: 0.02),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Last Name',
                        style: TextStyle(
                            fontWeight:
                            FontWeight.w400,
                            fontSize: 13,
                            fontFamily:
                            'Montserrat Bold',
                            color: AppColors
                                .appColor0),
                        textAlign: TextAlign.start,
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
                        initialValue:  BaseController.user_data['last_name'],
                        style: const TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Montserrat SemiBold',
                            color: AppColors.appColor0
                        ),
                        decoration:
                        InputDecorationValues02(hintText: BaseController.user_data['last_name']),
                        validator: (value) {
                          if ( value!.isNotEmpty && value.length < 3) {
                            return 'Name too short';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            account.last_name = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context,
                          scale: 0.02),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Username',
                        style: TextStyle(
                            fontWeight:
                            FontWeight.w400,
                            fontSize: 13,
                            fontFamily:
                            'Montserrat Bold',
                            color: AppColors
                                .appColor0),
                        textAlign: TextAlign.start,
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
                        initialValue:  BaseController.user_data['username'],
                        style: const TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Montserrat SemiBold',
                            color: AppColors.appColor0
                        ),
                        decoration:
                        InputDecorationValues02(hintText: BaseController.user_data['username']),
                        onChanged: (val) {
                          setState(() {
                            account.username = val;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context,
                          scale: 0.01),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Phone Number',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.appColor0),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context,
                          scale: 0.015),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.appColor4,
                      ),
                      child: InternationalPhoneNumberInput(
                        textStyle: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.color10),
                        inputDecoration: InputDecorationValues02(
                            hintText: '0' + BaseController.user_data['phone_number'].toString().substring(4)),
                        onInputChanged: (PhoneNumber number) {
                          setState(() {
                            account.phone_number = number.toString();
                          });
                        },

                        // onInputValidated: (bool value) {
                        //   setState(() {
                        //     valid = value;
                        //   });
                        // },
                        selectorConfig: const SelectorConfig(
                            selectorType:
                            PhoneInputSelectorType.BOTTOM_SHEET,
                            leadingPadding: 0,
                            trailingSpace: false,
                            setSelectorButtonAsPrefixIcon: true),
                        ignoreBlank: false,
                        // autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'Montserrat Bold',
                            color: AppColors.color10),
                        initialValue: number,
                        textFieldController: _textController,
                        formatInput: false,
                        maxLength: 11,
                        keyboardType:
                        const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputBorder: const OutlineInputBorder(),
                        onSaved: (PhoneNumber number) {

                        },
                      ),
                    ),

                    SizedBox(
                      height: DeviceUtils.getScaledHeight(
                          context,
                          scale: 0.02),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Gender',
                        style: TextStyle(
                            fontWeight:
                            FontWeight.w400,
                            fontSize: 14,
                            fontFamily:
                            'Montserrat Bold',
                            color: AppColors
                                .appColor0),
                        textAlign: TextAlign.start,
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
                      child: DropdownButtonFormField(
                        value: BaseController.user_data['gender'] ?? _selectedValue,
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
                        hint: Text(
                          BaseController.user_data['gender'] ?? 'select gender',
                        ),
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            _selectedValue = value.toString();
                            account.gender = value.toString();
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
                      height: DeviceUtils.getScaledHeight(
                          context,
                          scale: 0.02),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Date of birth',
                        style: TextStyle(
                            fontWeight:
                            FontWeight.w400,
                            fontSize: 14,
                            fontFamily:
                            'Montserrat Bold',
                            color: AppColors
                                .appColor0),
                        textAlign: TextAlign.start,
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
                        controller: dateCtl,
                        style: const TextStyle(
                            fontSize: 13.0,
                            fontFamily: 'Montserrat SemiBold',
                            color: AppColors.appColor0
                        ),
                        onSaved: (value) {
                         },
                        decoration: InputDecorationValues02(
                            hintText:  BaseController.user_data['dob'] ?? "Date Of Birth"),
                        onTap: () async {
                          DateTime date = DateTime(1900);
                          FocusScope.of(context)
                              .requestFocus(new FocusNode());
                          date = (await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100)))!;
                          account.dob =
                              DateFormat('yyyy-MM-dd').format(date);
                          dateCtl.text =
                              DateFormat('yyyy-MM-dd').format(date);
                        },
                      ),
                    ),
                    SizedBox(
                      height: DeviceUtils.getScaledHeight(context,
                          scale: 0.05),
                    ),
                    RoundedLoadingButton(
                        controller: _btnController,
                        height: 40,
                        borderRadius: 10,
                        color: AppColors.appPrimaryColor,
                        successColor: AppColors.appPrimaryColor,
                        child: const Center(
                          child: Text(
                            'Update',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: 'Montserrat SemiBold',
                                color: AppColors.whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onPressed: () async {
                          if(_formKey.currentState!.validate()){
                            if ( await profileController
                                .updateUserAccount(account)) {
                              _btnController.reset();
                              _controller.open();
                            } else {
                              ToastWidget(
                                  context, profileController.message.value, profileController.weight.value, 3);
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
          SlidingUpPanel(
            maxHeight: DeviceUtils.getScaledHeight(context, scale: 0.43),
            minHeight: DeviceUtils.getScaledHeight(context, scale: 0),
            controller: _controller,
            backdropOpacity: 0.2,
            backdropEnabled: true,
            backdropTapClosesPanel: true,
            panel: SuccessfulUpdate(
                controller: _controller),
            boxShadow: const [],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          )
        ],
      ),
    );
  }
}




class SuccessfulUpdate extends StatefulWidget {
  PanelController controller;
  SuccessfulUpdate({Key? key, required this.controller}) : super(key: key);

  @override
  State<SuccessfulUpdate> createState() => _SuccessfulUpdateState();
}

class _SuccessfulUpdateState extends State<SuccessfulUpdate> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          Container(
            width: DeviceUtils.getScaledWidth(context, scale: 0.09),
            height: DeviceUtils.getScaledHeight(context, scale: 0.007),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.color13),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.03),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.appColor2,
                borderRadius: BorderRadius.circular(100)
              
            ),
            child: const Icon( Icons.check,
              color: AppColors.whiteColor,
              size: 40,
            ),
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          const Text(
            'Successful',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                fontFamily: 'Montserrat ExtraBold',
                color: AppColors.appColor0),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.01),
          ),
          const Text(
            'You have successfully updated \nyour profile',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: 'Montserrat Regular',
                color: AppColors.appColor0),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: DeviceUtils.getScaledHeight(context, scale: 0.03),
          ),

          GestureDetector(
            onTap: () {
              widget.controller.close();
            },
            child: Container(
              width:
              DeviceUtils.getScaledWidth(context, scale: 0.7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.appPrimaryColor),
              padding: const EdgeInsets.symmetric(
                  horizontal: 25, vertical: 12),
              child: const Text(
                'Done',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Montserrat Bold',
                    color: AppColors.whiteColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
