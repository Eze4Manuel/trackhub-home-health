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

  Future<bool> pendingPayment() async {
    var url = Uri.parse('${Strings.domain}v1/admin/dispatches/create-unpaid-dispatch');
    List<Location> locations = await locationFromAddress(BaseController.selectedAddress['address']);

    print( BaseController.testOrders);
    print( BaseController.user_data['company_id']);

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
      requestPartnerType: BaseController.user_data['partner_type'],
      requestDetails: reqDetails,
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
      BaseController.selectedLab.clear();
      BaseController.selectedAddress.clear();
      BaseController.totalCost = 0;
      BaseController.unpaidID = '';
      setMessage('Request has been placed');
      return Future<bool>.value(true);
    }
  }


  Future<bool> activateDispatch(int index) async {
    // var data = {
    //   "dispatch_status": 'active',
    //   "request_id": BaseController.assignedDipatches[index]['request_id'],
    //   "company_id": BaseController.assignedDipatches[index]['company_id']
    // };
    // var url = Uri.parse('${Strings.domain}v1/admin/dispatches/update-dispatch?_id=${BaseController.assignedDipatches[index]['_id']}');
    // // Sending parameters to http request. Implemented in base controller
    // var result = await sendAuthorizedHttpRequest(url, data, 'put');
    // if (result == false) {
    //   return result;
    // } else {
    //   BaseController.assignedDipatches[index]['dispatch_status'] = 'active';
    //   return Future<bool>.value(true);
    // }
    return false;
  }

  Future<bool> fulfillDispatch(int index) async {
    // var data = {
    //   "dispatch_status": 'fulfilled',
    //   "request_id": BaseController.assignedDipatches[index]['request_id'],
    //   "company_id": BaseController.assignedDipatches[index]['company_id']
    // };
    // var url = Uri.parse('${Strings.domain}v1/admin/dispatches/update-dispatch?_id=${BaseController.assignedDipatches[index]['_id']}');
    // // Sending parameters to http request. Implemented in base controller
    // var result = await sendAuthorizedHttpRequest(url, data, 'put');
    // if (result == false) {
    //   return result;
    // } else {
    //   BaseController.assignedDipatches[index]['dispatch_status'] = 'fulfilled';
    //   return Future<bool>.value(true);
    // }
    return false;
  }

  Future<bool> updateStatus(bool status) async {
    // final prefs = await SharedPreferences.getInstance();
    // var url = Uri.parse('${Strings.domain}v1/admin/agents/update-agent?_id=${prefs.get('user_id')}');
    // print(status);
    // var data = {
    //   "status": status,
    //   "agent_type": 'rider'
    // };
    // // Sending parameters to http request. Implemented in base controller
    // var result = await sendAuthorizedHttpRequest(url, data, 'put');
    //
    // if (result == false) {
    //   return result;
    // } else {
    //   BaseController.user_data = (BaseController.user_data.isEmpty) ? result : BaseController.user_data;
    //   return Future<bool>.value(true);
    // }
    return false;
  }
}
