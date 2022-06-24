import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/model/debit_card.dart';
import 'package:trackhub_home_health/app/model/dispatch.dart';
import 'package:trackhub_home_health/app/model/request_details.dart';
import 'package:trackhub_home_health/app/ui/theme/app_strings.dart';
import 'package:http/http.dart' as http;

class DashboardController extends BaseController {
  RxBool loading = false.obs;

  Future<bool> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    var url = Uri.parse(
        '${Strings.domain}v1/admin/customers/get-customer/${prefs.get('user_id')}');
    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'get');
    if (result == false) {
      return result;
    } else {
      BaseController.user_data = result;
      return Future<bool>.value(true);
    }
  }

  Future<bool> getLabs() async {
    var url = Uri.parse(
        '${Strings.domain}v1/admin/partners/get-partners?type=superpartner');
    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'get');
    if (result == false) {
      return result;
    } else {
      BaseController.laboratories = result;
      return Future<bool>.value(true);
    }
  }

  Future<bool> fetchPickupData() async {
    final result = await Future.wait([
      getTests(),
      getSpecimen()
    ]);

    if(result[0] && result[1]){
      return true;
    }else{
      return false;
    }
  }



  Future<bool> getTests() async {
    var url = Uri.parse(
        '${Strings.domain}v1/admin/settings/get-single-partner-test/${BaseController.selectedLab['company_id']}');
    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'get');
    if (result == false) {
      return result;
    } else {
      BaseController.testPrices = result['test_prices'] ?? [];
      return Future<bool>.value(true);
    }
  }


  Future<bool> getDetinationCost() async {

     var url = Uri.parse(
        '${Strings.domain}v1/admin/settings/get-destination-cost?origin_address=${BaseController.selectedAddress['address']}&destination_address=${BaseController.selectedLab['address']}');
    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'get');
    print(url);
    if (result == false) {
      return result;
    } else {
       BaseController.logistics = result;
       print(BaseController.logistics);
      return Future<bool>.value(true);
    }
  }

  Future<bool> getSpecimen() async {
    var url = Uri.parse(
        '${Strings.domain}v1/admin/settings/get-specimens');
    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'get');
    if (result == false) {
      return result;
    } else {
      BaseController.specimens = result[0]['specimen_type'] ?? [];
      return Future<bool>.value(true);
    }
  }



  Future<bool> pendingPayment() async {
    var url = Uri.parse('${Strings.domain}v1/admin/dispatches/create-unpaid-dispatch');
    List<Location> locations = await locationFromAddress(BaseController.selectedAddress['address']);
    print(url);

    List reqDetails = BaseController.testOrders.map((elem) => {
          ...RequestDetail(
              nameOfPatient: BaseController.user_data['first_name'] +
                  " " +
                  BaseController.user_data['last_name'],
              specimenType: '',
              testType: elem['name'],
              noOfBottles: elem['noOfBottles'],
              moreInfo: elem['moreInfo'],
              price: elem['price']).toJson()
        }).toList();

    Dispatch dispatch = Dispatch(
      companyId: BaseController.user_data['company_id'],
      companyName: BaseController.user_data['first_name'] +
          " " +
          BaseController.user_data['last_name'],
      recipientCompanyId: BaseController.selectedLab['company_id'],
      requestId: BaseController.user_data['_id'],
      requestName: BaseController.user_data['first_name'] +
          " " +
          BaseController.user_data['last_name'],
      requestEmail: BaseController.user_data['email'],
      requestPhoneNumber: '0' + BaseController.user_data['phone_number'].toString().substring(4),
      requestType: '${BaseController.user_data['partner_type']}-${BaseController.requestType}',
        requestDetails: reqDetails,
        requestInfo: BaseController.requestInfo,
      dispatchStatus: 'inactive',
      dispatchInfo: BaseController.selectedAddress['addressInfo'],
      pickupAddress: BaseController.selectedAddress['address'],
      dropoffAddress: BaseController.selectedLab['address'],
      dropoffName: BaseController.selectedLab['company_name'],
      dropoffArea: BaseController.selectedLab['area'],
      dropoffCity: BaseController.selectedLab['city'],
      pickupLatitude: locations[0].latitude,
      pickupLongitude: locations[0].longitude,
      dropoffLatitude: BaseController.selectedLab['company_location']['coordinates'][0],
      dropoffLongitude: BaseController.selectedLab['company_location']['coordinates'][1],
      paymentStructureType: 'pay-as-you-go',
      paymentStructureAmount: BaseController.totalCost
    );

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, dispatch.toJson(), 'post');
    if (result == false) {
      return result;
    } else {
      BaseController.unpaidID = result['_id'];
      return Future<bool>.value(true);
    }
  }

  //
  // Future<bool> setupMethod() async {
  //   var temp = false;
  //   await Future.wait([getLabs(), getTests()]).then((v) {
  //     if (v[0] && v[1]) {
  //       temp = true;
  //     } else {
  //       temp = false;
  //     }
  //   }, onError: (err) {
  //     temp = false;
  //   });
  //   return temp;
  // }

  Future<bool> paymentMadeUpdate(DebitCard debitCard, bool isChecked) async {
    var data = {
      "card_details": debitCard.toJson(),
      "save_as_default": isChecked,
      "user_id": BaseController.user_data["_id"]
    };
    var url = Uri.parse('${Strings.domain}v1/admin/dispatches/update-unpaid-dispatch?_id=${BaseController.unpaidID}');

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'put');
    if (result == false) {
      return result;
    } else {
      // clearing variables data;
      BaseController.testOrders.clear();
      BaseController.testPrices.clear();
      // BaseController.selectedLab.clear();
      BaseController.selectedAddress.clear();
      BaseController.totalCost = 0;
      BaseController.unpaidID = '';
      BaseController.requestInfo = '';
      BaseController.requestType = '';

      setMessage('Request has been placed');
      return Future<bool>.value(true);
    }
  }


}
