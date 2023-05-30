import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/models.dart';
import 'package:proyecto_final_factores_app/app/modules/home/controllers/home_controller.dart';
import 'package:proyecto_final_factores_app/app/routes/app_pages.dart';
import 'package:proyecto_final_factores_app/app/services/services.dart';
import 'package:proyecto_final_factores_app/app/widgets/widgets.dart';

class ShoppingCartController extends GetxController {
  HomeController homeController = Get.find();
  RxList cards = [].obs;
  CreditCard? card;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    getCrditCards();
    super.onInit();
  }

  /// Va a la pestaña de agregar tarjeta
  goToAddCard() async {
    await Get.toNamed(Routes.ADD_CREDIT_CARD,
        arguments: {'id': homeController.user.id});
    getCrditCards();
  }

  selectCard(CreditCard creditCard) {
    cards.forEach((element) {
      element.isSelected.value = false;
    });
    creditCard.isSelected!.value = true;
    card = creditCard;
  }

  /// Trae las tarjetas de crédito del usuario
  getCrditCards() async {
    isLoading.value = true;
    cards = await creditCardService.getUserCreditCards(
      documentId: homeController.user.id!,
    );
    isLoading.value = false;
  }

  /// Aumenta o disminuye el stock
  addLessStock(bool isAdd, ShoppingCartModel shopCart) {
    if (isAdd) {
      if (shopCart.product!.stock! > shopCart.stock!.value) {
        shopCart.stock!.value++;
      } else {
        CustomSnackBars.showErrorSnackBar(
          'El producto no tiene más stock disponible',
        );
      }
    } else {
      if (shopCart.stock!.value > 1) {
        shopCart.stock!.value--;
      }
    }
  }

  pay() {
    if (card != null) {
    } else {}
  }
}
