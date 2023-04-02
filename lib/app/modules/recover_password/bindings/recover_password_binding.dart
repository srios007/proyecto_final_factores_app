import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/modules/recover_password/controllers/recover_password_controller.dart';

class RecoverPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecoverPasswordController>(
      () => RecoverPasswordController(),
    );
  }
}
