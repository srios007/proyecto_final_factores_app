import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/models.dart';
import 'package:proyecto_final_factores_app/app/routes/app_pages.dart';

class CreditCardsListController extends GetxController {
  RxList cards = [].obs;

  @override
  void onInit() {
    cards.add(
      CreditCard(
        cardNumber: '4093 5500 0055 5577',
        cardHolderName: 'Santiago Rios',
        expiryDate: '10/23',
      ),
    );
    // cards.add(
    //   CreditCard(
    //     cardNumber: 'Edwin Hernández',
    //     cardHolderName: '12',
    //     expiryDate: 'UDOI',
    //   ),
    // );
    // cards.add(
    //   CreditCard(
    //     cardNumber: 'Sebastián González',
    //     cardHolderName: '23',
    //     expiryDate: 'ISML',
    //   ),
    // );
    super.onInit();
  }

  /// Va a la pestaña de agregar tarjeta
  goToAddCard() async {
    final result = await Get.toNamed(Routes.ADD_CREDIT_CARD);
    if (result != null) {
      cards.add(result);
    }
  }
}

 
