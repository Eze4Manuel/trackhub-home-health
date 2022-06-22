import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/model/account.dart';
import 'package:trackhub_home_health/app/ui/theme/app_strings.dart';

class AuthenticationController extends BaseController {
  RxBool loading = false.obs;
  static String addressInfo = '';
  static String user_email = '';

  Future<bool> loginUserAccount(String? name_field, String? password) async {
    dynamic data;
    final prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('${Strings.domain}v1/admin/auth/login/customers');

    data = {"name_field": name_field, "password": password};

    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data, 'post');

    if (result == false) {
      if(BaseController.emailRegex
          .hasMatch(name_field!) ){
        AuthenticationController.user_email = name_field;
      }

      return result;
    } else {
      prefs.setString('user_id', result['user_id']);
      prefs.setString('token', result['token']);
      BaseController.user_data = result;

      setMessage("Login Success");
      return Future<bool>.value(true);
    }
  }

  Future<bool> signUpAccount(Account? account) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}v1/admin/customers/create-customer');
    data = account?.toJson();

    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data, 'post');
    if (result == false) {
      return result;
    } else {
      AuthenticationController.user_email = data['email'];
      setMessage("Account Created, Verify Email");
      return Future<bool>.value(true);
    }
  }

  Future<bool> updateAddress(String email, String? address, String more_info) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}v1/admin/customers/update-customer-address?email=${email}');
    data = {
      "address": address,
      "more_info": more_info
    };
    print(url);
    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data, 'put');

    if (result == false) {
      return result;
    } else {
      setMessage("Address updated");
      return Future<bool>.value(true);
    }
  }

  Future<bool> verifyAccount(String code) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}v1/admin/customers/verify-customer-account?email=${AuthenticationController.user_email}');
    data = {
      "code": code
    };
    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data, 'put');

    if (result == false) {
      return result;
    } else {
      setMessage("Account Verified");
      return Future<bool>.value(true);
    }
  }

  Future<bool> resendCode(String email) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}v1/admin/customers/resend-account-code?email=$email');

    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, {}, 'put');

    if (result == false) {
      return result;
    } else {
      setMessage("Code Sent to Email");
      return Future<bool>.value(true);
    }
  }

  Future<bool> forgotPassword(String email) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}v1/admin/customers/forgot-password?email=$email');

    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, {}, 'put');

    if (result == false) {
      return result;
    } else {
      AuthenticationController.user_email = email;

      setMessage("Code Sent to Email");
      return Future<bool>.value(true);
    }
  }

  Future<bool> resetPassword(String code, String newPassword) async {
    dynamic data;
    var url = Uri.parse('${Strings.domain}v1/admin/customers/reset-password?email=${AuthenticationController.user_email}');

    data = {
      "code": code,
      "password": newPassword,
    };
    // Sending parameters to http request. Implemented in base controller
    var result = await sendHttpRequest(url, data, 'put');

    if (result == false) {
      return result;
    } else {
      setMessage("Password Reset Success");
      return Future<bool>.value(true);
    }
  }





}
