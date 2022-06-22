import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:trackhub_home_health/app/controller/base_controller.dart';

class HomeController extends BaseController {
  RxBool loading = false.obs;
  RxBool notification = false.obs;

  void setNotify() async {
     notification.value = true;
  }

}
