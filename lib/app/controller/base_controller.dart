import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:trackhub_home_health/app/utils/shared_prefs.dart';

import '../../.env.dart';

class BaseController extends GetxController {
  static Map<String, dynamic> user_data = {};
  static List laboratories = [];
  static List testOrders = [];
  static List testPrices = [];
  static List areaLists = [];
  static double totalCost = 0;
  static Map<String, dynamic> selectedLab = {};
  static Map<String, dynamic> selectedAddress = {};
  static String? unpaidID;
  static String? requestType;
  static String? requestInfo = '';
  static List notifications = [];
  static List specimens = [];


  static List departments = [];
  static List tickets = [];
  static List dispatches = [];
  static List assignedDipatches = [];
  static Map<String, dynamic> selectedTicket = {} ;
  static Map<String, dynamic> assignedPhlebotomist = {} ;
  static Map<String, dynamic> logistics = {} ;


  static RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  static PersistentTabController persistentController =
  PersistentTabController(initialIndex: 0);


  RxString message = ''.obs;
  RxString weight = ''.obs;

  setMessage(msg){
    message.value = msg;
  }

  setWeight(type){
    weight.value = type;
  }

  static int getTestOrderLength(){
    return testOrders.length;
  }

  static Map<String, dynamic> getSelectedAddress(){
    return selectedAddress;
  }

  static Map<String, dynamic> getSelectedLab(){
    return selectedLab;
  }

  //------------ Stores data locally using Shared prefs ------------//
  Future<bool> storeUserDetails(body, listKeys) async {
    await listKeys.map((key) async =>
    await SharedPrefs.saveString(key, body[key])
    );
    return true;
  }

  sendHttpRequest( url, data, httpMethod) async {
    // unsetting messages
    setMessage('');
    try {
      print("processing");
      http.Response response;

      switch(httpMethod){
        case 'get':
          response =
          await http.get(
              url,
              headers: {"Accept": "*/*", "Content-Type": "application/json"});
          break;

        case 'put':
          response =
          await http.put(
              url,
              headers: {"Accept": "*/*", "Content-Type": "application/json"},
              body: jsonEncode(data));
          break;

        default:
          response =
          await http.post(
              url,
              headers: {"Accept": "*/*", "Content-Type": "application/json"},
              body: jsonEncode(data));
      }
      if(jsonDecode(response.body)['status'] == 'success') {
        setWeight('success');
        return jsonDecode(response.body)['data'];
      }
      else{
        setMessage(jsonDecode(response.body)['msg']);
        setWeight('danger');
        return Future<bool>.value(false);
      }
    }catch(e){
      print(e);
      setMessage("Something went wrong");
      return Future<bool>.value(false);
    }
  }

  sendDirectionsGetHttpRequest( url, data, httpMethod) async {
    http.Response response;
    try{
        response =
        await http.get(
            url,
            headers: {"Accept": "*/*", "Content-Type": "application/json"});
      }catch(err){
        print(err);
        setMessage("Something went wrong");
        return Future<bool>.value(false);
      }
      return jsonDecode(response.body);
  }

  sendAuthorizedHttpRequest( url, data, httpMethod) async {
    // unsetting messages
    setMessage('');
    try {
      print("processing");

      var token = await SharedPrefs.readSingleString('token');
      http.Response response;
      switch(httpMethod){

        case 'get':
          response =
          await http.get(
              url,
              headers: {
                "Accept": "*/*",
                "Content-Type": "application/json",
                "Authorization": "Bearer $token"
              });

          break;
        case 'put':
          response =
          await http.put(
              url,
              headers: {
                "Accept": "*/*",
                "Content-Type": "application/json",
                "Authorization": "Bearer $token"
              },
              body: jsonEncode(data));
          break;
        case 'delete':
          response =
          await http.delete(
              url,
              headers: {
                "Accept": "*/*",
                "Content-Type": "application/json",
                "Authorization": "Bearer $token"
              },
             );
          break;

        default:
           response =
          await http.post(
              url,
              headers: {
                "Accept": "*/*",
                "Content-Type": "application/json",
                "Authorization": "Bearer $token"
              },
              body: jsonEncode(data));
          break;
      }

      print('Response status: ${response.statusCode}');
      print('Response body: ${jsonDecode(response.body)}');

      if(jsonDecode(response.body)['status'] == 'success') {
        setWeight('success');
        return jsonDecode(response.body)['data'];
      }
      else{
        setWeight('danger');
        setMessage(jsonDecode(response.body)['msg']);
        return Future<bool>.value(false);
      }
    }catch(e){
      print(e);
      setMessage("Something went wrong");
      return Future<bool>.value(false);
    }
  }

}