
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';
import 'package:trackhub_home_health/app/ui/theme/app_strings.dart';

class TicketController extends BaseController {

  RxBool loading = false.obs;
  RxList lawEnforcementAgencies = [].obs;
  List videoListing = [];
  // ignore: prefer_typing_uninitialized_variables
  var locationDetails;


  Future<bool> getDepartments(String type) async {
    final prefs = await SharedPreferences.getInstance();

    // var url = Uri.parse('${Strings.domain}v1/admin/dispatches/get-dispatches/${prefs.get('user_id')}');
    var url = Uri.parse('${Strings.domain}v1/admin/settings/get-departments');

    print(url);
    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'get');

    if (result == false) {
      return result;
    } else {
      BaseController.departments = result[0]['department_data'];
      return Future<bool>.value(true);
    }
  }


  Future<bool> createTicket(String? department, String? subject, String? message) async {
    dynamic data;
    final prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('${Strings.domain}v1/admin/tickets/create-ticket');

    data = {"issuer_id": BaseController.user_data['user_id'] ?? BaseController.user_data['_id'], "issuer_email": BaseController.user_data['email'], "department": department, "subject": subject, "detailed_description": message};

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'post');

    print(data);
    if (result == false) {
      return result;
    } else {
      setMessage("Ticket created");
      return Future<bool>.value(true);
    }
    return false;
  }


  Future<bool> getTickets() async {
    final prefs = await SharedPreferences.getInstance();

    var url = Uri.parse('${Strings.domain}v1/admin/tickets/get-issuer-tickets?_id=${prefs.get('user_id')}');

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'get');

    if (result == false) {
      return result;
    } else {
      BaseController.tickets = result;
      return Future<bool>.value(true);
    }
  }


  Future<bool> getSingleTicket(String ticketID) async {
    var url = Uri.parse('${Strings.domain}v1/admin/tickets/get-ticket/${ticketID}');
    print(url);

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, {}, 'get');

    if (result == false) {
      return result;
    } else {
      BaseController.selectedTicket = result;
      return Future<bool>.value(true);
    }
  }


  Future<bool> sendComment(String? message, String? ticket_id, String? confluence_id) async {
    print(message);
    dynamic data;
    final prefs = await SharedPreferences.getInstance();
    var url = Uri.parse('${Strings.domain}v1/admin/tickets/update-ticket-comment?_id=${ticket_id}');
    print(url);
    data = {"message": message, "confluence_id": confluence_id, "ticket_id": ticket_id, "messenger_name": '${BaseController.user_data['first_name']} ${BaseController.user_data['last_name']}', "messenger_id": prefs.get('user_id')};

    // Sending parameters to http request. Implemented in base controller
    var result = await sendAuthorizedHttpRequest(url, data, 'put');

    print(data);
    if (result == false) {
      return result;
    } else {
      setMessage("Ticket updated");
      return Future<bool>.value(true);
    }
  }

}
