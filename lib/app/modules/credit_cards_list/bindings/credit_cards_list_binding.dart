import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/modules/credit_cards_list/controllers/credit_cards_list_controller.dart';

class CreditCardsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreditCardsListController>(
      () => CreditCardsListController(),
    );
  }
}
