

import 'package:get/get.dart';
import 'package:todo_app_getx/controllers/global_controller.dart';

class BinderController implements Bindings {
  @override
  void dependencies() {
    Get.put(GlobalController(), permanent: true);

  }
}
