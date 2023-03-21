import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/models.dart';
import 'package:proyecto_final_factores_app/app/routes/app_pages.dart';
import 'package:proyecto_final_factores_app/app/services/model_services/credit_card_service.dart';
import 'package:proyecto_final_factores_app/app/widgets/widgets.dart';

class ProductDetailController extends GetxController {
  Product product = Get.arguments['product'];
  RxBool isLoading = false.obs;
  RxList cards = [].obs;
  String id = Get.arguments['id'];
  CreditCard? card;

  @override
  void onInit() async {
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

  selectCard(CreditCard creditCard) {
    cards.forEach((element) {
      element.isSelected.value = false;
    });
    creditCard.isSelected!.value = true;
    card = creditCard;
  }

  pay() {
    if (card != null) {
      CustomSnackBars.showSuccessSnackBar('Compra completada con éxito');
      Get.offAllNamed(Routes.HOME);
    } else {
      CustomSnackBars.showErrorSnackBar(
        'Por favor, agrega o escoge una tarjeta de crédito',
      );
    }
  }
}
