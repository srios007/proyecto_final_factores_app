import 'package:flutter/widgets.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/models.dart';
import 'package:proyecto_final_factores_app/app/services/services.dart';
import 'package:proyecto_final_factores_app/app/widgets/widgets.dart';

class AddCreditCardController extends GetxController {
  RxString cardHolderNameController = ''.obs;
  RxString cardNumberController = ''.obs;
  RxString expiryDateController = ''.obs;
  RxString cvvCodeController = ''.obs;
  final key = GlobalKey<FormState>();
  RxBool isCvvFocused = false.obs;
  RxBool isLoading = false.obs;
  CreditCard card = CreditCard();

  /// Agrega la tarjeta de crédito
  addCreditCard() async {
    if (key.currentState!.validate() && validteFields()) {
      card.cardNumber = cardNumberController.value;
      card.expiryDate = expiryDateController.value;
      card.cardHolderName = cardHolderNameController.value;
      card.cvvCode = cvvCodeController.value;
      isLoading.value = true;
      final result = await creditCardService.addCreditCard(
        documentId: Get.arguments['id'],
        creditCard: card,
      );
      validateResult(result);
      isLoading.value = false;
    }
  }

  /// Valida si la tarjeta se agregó
  validateResult(bool result) {
    if (result) {
      Get.back();
      CustomSnackBars.showSuccessSnackBar('Tarjeta creada con éxito');
    } else {
      CustomSnackBars.showErrorSnackBar(
        'Error al crear la tarjeta, por favor intente de nuevo',
      );
    }
  }

  /// Settea los datos en el CreditCardWidget
  onCreditCardModelChange(CreditCardModel creditCardModel) {
    cardNumberController.value = creditCardModel.cardNumber;
    expiryDateController.value = creditCardModel.expiryDate;
    cardHolderNameController.value = creditCardModel.cardHolderName;
    cvvCodeController.value = creditCardModel.cvvCode;
    isCvvFocused.value = creditCardModel.isCvvFocused;
  }

  validteFields() {
    if (cardNumberController.value.isEmpty ||
        cardNumberController.value.length < 16) {
      CustomSnackBars.showErrorSnackBar(
        'Por favor, revisa el número de tu tarjeta',
      );
      return false;
    } else if (cvvCodeController.value.isEmpty ||
        cvvCodeController.value.length < 3) {
      CustomSnackBars.showErrorSnackBar('Por favor, revisa el CCV');
      return false;
    } else if (expiryDateController.value.isEmpty) {
      CustomSnackBars.showErrorSnackBar(
        'Por favor, rellena la fecha de expiración',
      );
      return false;
    } else if (cardHolderNameController.value.isEmpty) {
      CustomSnackBars.showErrorSnackBar(
        'Por favor, rellena el titular de la tarjeta',
      );
      return false;
    } else if (expiryDateController.value.isNotEmpty) {
      return validateDate();
    } else {
      return true;
    }
  }

  validateDate() {
    final List<String> date = expiryDateController.value.split(RegExp(r'/'));
    final int month = int.parse(date.first);
    final int year = int.parse('20${date.last}');
    final int lastDayOfMonth = month < 12
        ? DateTime(year, month + 1, 0).day
        : DateTime(year + 1, 1, 0).day;
    final DateTime cardDate =
        DateTime(year, month, lastDayOfMonth, 23, 59, 59, 999);
    if (cardDate.isBefore(DateTime.now()) || month > 12 || month == 0) {
      CustomSnackBars.showErrorSnackBar('Por favor, elige una fecha vigente');
      return false;
    } else {
      return true;
    }
  }
}
