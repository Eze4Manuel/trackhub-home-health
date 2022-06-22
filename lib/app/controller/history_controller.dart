import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/ui/theme/app_strings.dart';


class HistoryController extends BaseController {
  RxBool loading = false.obs;


  Future<bool> getDispatches(String type) async {
    final prefs = await SharedPreferences.getInstance();

    var url = Uri.parse('${Strings.domain}v1/admin/dispatches/get-dispatches?q=${type}&company_id=${BaseController.user_data['company_id']}');

    print(url);
    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'get');

    if (result == false) {
      return result;
    } else {
      BaseController.dispatches = result;
      BaseController.dispatches = BaseController.dispatches.reversed.toList();

      return Future<bool>.value(true);
    }
  }

  Future<bool> setToUnassign(String dispatch_id) async {

    var url = Uri.parse('${Strings.domain}v1/admin/dispatches/unassign-dispatch?_id=${dispatch_id}');

    print(url);
    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'put');
    if (result == false) {
      return result;
    } else {
      BaseController.assignedDipatches.removeWhere(
              (element) =>
          (element['_id']) == dispatch_id);
      return Future<bool>.value(true);
    }
  }

  Future<bool> getPhlebotomistDetail(String dispatcher_id) async {

    var url = Uri.parse('${Strings.domain}v1/admin/agents/get-agent/${dispatcher_id}');
    print(url);
     // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'get');

    if (result == false) {
      return result;
    } else {
       BaseController.assignedPhlebotomist = result;
      return Future<bool>.value(true);
    }
  }

}
