import 'package:get/get.dart';

import '../controllers/asking_controller.dart';

class AskingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AskingController>(
      () => AskingController(),
    );
  }
}
