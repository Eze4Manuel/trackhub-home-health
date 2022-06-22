import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/ui/theme/app_strings.dart';

class NotificationController extends BaseController {
  RxBool loading = false.obs;

  Future<bool> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    var url = Uri.parse(
        '${Strings.domain}v1/admin/notifications/get-unread-notifications?q=${prefs.get('user_id')}');

    print(url);
    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'get');

    if (result == false) {
      return result;
    } else {
      BaseController.notifications = result;
      return Future<bool>.value(true);
    }
  }

  Future<bool> updateNotification(String _id) async {
    print(_id);
    var url = Uri.parse(
        '${Strings.domain}v1/admin/notifications/update-notification-status?_id=${_id}');
    var data = {'status': true};
    print(url);
    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'put');

    if (result == false) {
      return result;
    } else {
      return Future<bool>.value(true);
    }
  }
}
