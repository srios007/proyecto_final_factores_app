import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/modules/add_credit_card/controllers/add_credit_card_controller.dart';

class AddCreditCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCreditCardController>(
      () => AddCreditCardController(),
    );
  }
}
