import 'package:get/get.dart';

import '../controllers/credit_cards_list_controller.dart';

class CreditCardsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreditCardsListController>(
      () => CreditCardsListController(),
    );
  }
}
