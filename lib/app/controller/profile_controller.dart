import 'dart:convert';
import 'dart:io';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackhub_home_health/app/ui/theme/app_strings.dart';
import 'package:trackhub_home_health/app/utils/shared_prefs.dart';
import '../model/account.dart';
import 'base_controller.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';


class ProfileController extends BaseController {
  RxBool loading = false.obs;

  Future<bool> updateUserAccount(Account account) async {

    Map data;
    final prefs = await SharedPreferences.getInstance();
    
    var url = Uri.parse('${Strings.domain}v1/admin/customers/update-customer?_id=${prefs.get('user_id')}');

    data = account.toUpdateJson();
    print(url);
    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'put');

    if (result == false) {
      return result;
    } else {
      data.forEach((key, value) {
        BaseController.user_data[key] = value;
      });
      // setMessage("Update Successfu")
      return Future<bool>.value(true);
    }
  }

  Future<bool> updateUserPassword(String old_password, String new_password) async {
    Map data;
    final prefs = await SharedPreferences.getInstance();

    var url = Uri.parse('${Strings.domain}v1/admin/customers/update-customer-password?_id=${prefs.get('user_id')}');

    data = {
      'old_password': old_password,
      'new_password': new_password,
      'agent_type': 'rider'
    };
      print(data);
      print(url);
      // Sending parameters to http request. Implemented in base controller
      var result = await sendAuthorizedHttpRequest(url, data, 'put');
      print(result);
      if (result == false) {
        return result;
      } else {
        data.forEach((key, value) {
          BaseController.user_data[key] = value;
        });
        setMessage('Password updated');
        return Future<bool>.value(true);

      }
    }



  Future<bool> asyncFileUpload (String text, File file) async {
    final prefs = await SharedPreferences.getInstance();

    var urlS3Upload = Uri.parse('${Strings.domain}v1/admin/settings/get-secure-url?imageName=${DateTime.now().millisecondsSinceEpoch.toString()}--${basename(file.path)}');
    var s3result = await sendAuthorizedHttpRequest(urlS3Upload, {}, 'get');
    if (s3result == false) {
      return s3result;
    } else {

      List<int> imageData = file.readAsBytesSync();

      var response = await http.put(Uri.parse(s3result['url']), body: imageData, headers: {
        "Content-Type": "octet-stream",
        "Content-Disposition": 'attachment; filename="profile-image"',
        "Content-Encoding": "identity",
        "Content-Length": file.lengthSync().toString()
      });

      if (response.statusCode == 201 || response.statusCode == 200 ) {
        print( 'submit video response: ' + response.toString() );
      } else {
        throw Exception('Failed to post story');
      }
      var url = Uri.parse('${Strings.domain}v1/admin/customers/update-customer?_id=${prefs.get('user_id')}');

      var data = {
        "image_url": s3result['url'].toString().split('?')[0]
      };
      // Sending parameters to http request. Implemented in base controller
      var result = await sendAuthorizedHttpRequest(url, data, 'put');

      if (result == false) {
        return result;
      } else {
        BaseController.user_data['image_url'] = s3result['url'].toString().split('?')[0];
        return Future<bool>.value(true);
      }
     }
  }


  Future<bool> logout() async {
    await SharedPrefs.remove('user_id');
    await SharedPrefs.remove('token');
    return true;
  }



  }

