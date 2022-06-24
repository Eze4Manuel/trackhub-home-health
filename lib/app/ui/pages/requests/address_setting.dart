import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:trackhub_home_health/app/controller/authentication_controller.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:trackhub_home_health/app/ui/theme/app_colors.dart';
import 'package:trackhub_home_health/app/utils/widget_utils.dart';
import 'package:uuid/uuid.dart';

import '../../../controller/base_controller.dart';
import '../../../controller/dashboard_controller.dart';
import '../../../model/place_service.dart';
import '../../../utils/device_utils.dart';


class AddressSetting extends StatefulWidget {

  PanelController specimenController;
  PanelController addressController;
  AddressSetting({ required this.specimenController, required this.addressController, Key? key}) : super(key: key);

  @override
  State<AddressSetting> createState() => _AddressSettingState();
}

class _AddressSettingState extends State<AddressSetting> {
  final _formKey = GlobalKey<FormState>();
  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();
  final _controller = TextEditingController();
  final AuthenticationController authenticationController =
  Get.put(AuthenticationController());
  final DashboardController dashboardController =
  Get.put(DashboardController());

  String address = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: DeviceUtils.getScaledHeight(context, scale: 0.01),
          horizontal: DeviceUtils.getScaledWidth(context, scale: 0.04)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
                height: DeviceUtils.getScaledHeight(context, scale: 0.05)),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,

                children: [
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
                        hintText: 'Select Address',
                        surfixIcon: const Icon(
                          Icons.my_location,
                          color: AppColors.appPrimaryColor,
                          size: 25,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isNotEmpty && value.length < 3) {
                          return 'Address not set';
                        }
                        return null;
                      },
                      onTap: () async {
                        final sessionToken = const Uuid().v4();
                        final Suggestions? result = await showSearch(
                          context: context,
                          delegate: AddressSearch(sessionToken),
                        );
                        // This will change the text displayed in the TextField
                        if (result != null) {
                          final placeDetails =
                          await PlaceApiProvider(sessionToken)
                              .getPlaceDetailFromId(result.placeId);
                          setState(() {
                            _controller.text = result.description;
                            address = result.description;
                          });
                          BaseController.selectedAddress['address'] = result.description;
                          BaseController.selectedAddress['addressInfo'] = AuthenticationController.addressInfo;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context,
                        scale: 0.02),
                  ),
                  address.isNotEmpty
                      ? RoundedLoadingButton(
                      controller: _btnController,
                      disabledColor: AppColors.appColor3,
                      height: 45,
                      borderRadius: 16,
                      color: AppColors.appPrimaryColor,
                      successColor: AppColors.appPrimaryColor,
                      child: const Center(
                        child: Text(
                          'Finish',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              fontFamily: 'Montserrat Bold',
                              color: AppColors.whiteColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () async {
                        if(await dashboardController.getDetinationCost()){
                          widget.addressController.close();
                          _btnController.reset();
                          widget.specimenController.open();
                        }else{
                          _btnController.reset();
                        }

                      })
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            border:  Border(
                                bottom: BorderSide(
                                    color: AppColors.color13, width: 0.7),
                                top: BorderSide(
                                    color: AppColors.color13, width: 0.7))
                        ),
                        child: ListTile(
                          onTap: () async{
                            BaseController.selectedAddress['address'] = BaseController.user_data['address'];
                            BaseController.selectedAddress['addressInfo'] = BaseController.user_data['more_info'];
                            if(await dashboardController.getDetinationCost()){
                            widget.addressController.close();
                            _btnController.reset();
                            widget.specimenController.open();
                            }else{
                            _btnController.reset();
                            }
                            // widget.specimenController.open();
                          },
                          horizontalTitleGap: 10,
                          minLeadingWidth: 15,
                          leading: const Icon(Icons.storage,
                            color: AppColors.appColor3,
                            size: 20,),
                          title: Text(BaseController.user_data["address"].toString(),
                            style: const TextStyle(
                                fontSize: 13.0,
                                fontFamily: 'Montserrat SemiBold',
                                color: AppColors.appColor3),),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: DeviceUtils.getScaledHeight(context,
                        scale: 0.04),
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


class AddressSearch extends SearchDelegate<Suggestions> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  late final sessionToken;
  late PlaceApiProvider apiClient;

  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle => const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      fontFamily: 'Montserrat Regular',
      color: AppColors.appColor3);

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Search';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(
          Icons.clear,
          color: AppColors.color7,
          size: 20,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith(
      inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
        isDense: true,
        fillColor: Colors.transparent,
        filled: false,
        focusColor: Colors.transparent,
        contentPadding: const EdgeInsets.fromLTRB(10.0, 13.0, 10.0, 13.0),
        border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(10)),
      ),
      primaryColor: Colors.transparent,
      textTheme: const TextTheme(
        headline6: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            fontFamily: 'Montserrat SemiBold',
            color: AppColors.appColor0),
      ),
    );
    return theme;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(
        Icons.arrow_back,
        color: AppColors.appColor0,
        size: 20,
      ),
      onPressed: () {
        close(context, Suggestions('', ''));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Suggestions>>(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
          query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'Enter your address',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: 'Montserrat SemiBold',
              color: AppColors.appColor0),
        ),
      )
          : snapshot.hasData
          ? Padding(
        padding: EdgeInsets.symmetric(
            vertical:
            DeviceUtils.getScaledHeight(context, scale: 0.01)),
        child: ListView.builder(
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(
                vertical: DeviceUtils.getScaledHeight(context,
                    scale: 0.005),
                horizontal:
                DeviceUtils.getScaledWidth(context, scale: 0.02)),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: AppColors.color13, width: 0.7))),
            child: ListTile(
              horizontalTitleGap: 10,
              minLeadingWidth: 15,
              leading: const Icon(
                Icons.location_on_outlined,
              ),
              title: Text(
                (snapshot.data![index]).description,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    fontFamily: 'Montserrat SemiBold',
                    color: AppColors.appColor0),
              ),
              onTap: () {
                close(context, snapshot.data![index]);
              },
            ),
          ),
          itemCount: snapshot.data!.length,
        ),
      )
          : const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Searching...',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: 'Montserrat Bold',
              color: AppColors.appColor0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
