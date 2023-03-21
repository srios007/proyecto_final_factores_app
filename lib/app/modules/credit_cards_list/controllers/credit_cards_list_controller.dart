import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/routes/app_pages.dart';
import 'package:proyecto_final_factores_app/app/services/services.dart';

class CreditCardsListController extends GetxController {
  RxBool isLoading = false.obs;
  RxList cards = [].obs;
  late String id;

  @override
  void onInit() async {
    id = Get.arguments['id'];
    getCrditCards();
    super.onInit();
  }

  /// Trae las tarjetas de crédito del usuario
  getCrditCards() async {
    isLoading.value = true;
    cards = await creditCardService.getUserCreditCards(
      documentId: id,
    );
    isLoading.value = false;
  }

  /// Va a la pestaña de agregar tarjeta
  goToAddCard() async {
    await Get.toNamed(Routes.ADD_CREDIT_CARD, arguments: {'id': id});
    getCrditCards();
  }
}
