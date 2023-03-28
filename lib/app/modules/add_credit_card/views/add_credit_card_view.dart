import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/modules/add_credit_card/controllers/add_credit_card_controller.dart';
import 'package:proyecto_final_factores_app/app/utils/utils.dart';
import 'package:proyecto_final_factores_app/app/widgets/widgets.dart';

class AddCreditCardView extends GetView<AddCreditCardController> {
  AddCreditCardView({super.key});
  final errorStyle = const TextStyle(height: 0, fontSize: 0);
  final labelStyle = TextStyle(color: Palette.mainBlue.withOpacity(0.7));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agregar tarjeta',
          style: TextStyle(color: Palette.mainBlue),
        ),
        centerTitle: true,
      ),
      floatingActionButton: addButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        bottom: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              cardWidget(),
              inputsSection(),
            ],
          ),
        ),
      ),
    );
  }

  /// Formulario para crear tarjeta
  inputsSection() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CreditCardForm(
          themeColor: Palette.mainBlue,
          formKey: controller.key,
          obscureNumber: false,
          obscureCvv: true,
          isHolderNameVisible: true,
          isCardNumberVisible: true,
          isExpiryDateVisible: true,
          cardHolderName: controller.cardHolderNameController.value,
          expiryDate: controller.expiryDateController.value,
          cardNumber: controller.cardNumberController.value,
          cvvCode: controller.cvvCodeController.value,
          cardNumberDecoration: setInputDecoration(
            labelText: 'Número de tarjeta',
            hintText: 'XXXX XXXX XXXX XXXX',
          ),
          expiryDateDecoration: setInputDecoration(
            labelText: 'Expiración',
            hintText: 'MM/YY',
          ),
          cvvCodeDecoration: setInputDecoration(
            labelText: 'CVV',
            hintText: 'XXX',
          ),
          cardHolderDecoration: setInputDecoration(
            labelText: 'Titular de la tajerta',
            hintText: '',
          ),
          cvvValidator: noValidate,
          cardHolderValidator: noValidate,
          cardNumberValidator: noValidate,
          expiryDateValidator: noValidate,
          onCreditCardModelChange: controller.onCreditCardModelChange,
        ),
      );
    });
  }

  /// Hace que los campos no sean validados automáticamente
  String? noValidate(_) {
    return null;
  }

  /// Botón que agrega la tarjeta
  addButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CustomButton(
        isLoading: controller.isLoading,
        onPressed: controller.addCreditCard,
        buttonText: 'Agregar',
      ),
    );
  }

  /// Widget de la tarjeta que el usuario está llenando
  cardWidget() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CreditCardWidget(
          cardNumber: controller.cardNumberController.value,
          expiryDate: controller.expiryDateController.value,
          cardHolderName: controller.cardHolderNameController.value,
          cvvCode: controller.cvvCodeController.value,
          showBackView: controller.isCvvFocused.value,
          onCreditCardWidgetChange: (creditCardBrand) {
            print(creditCardBrand);
          },
          isChipVisible: true,
          obscureCardNumber: false,
        ),
      ),
    );
  }

  /// Define la decoración del campo de texto
  setInputDecoration({
    required String labelText,
    required String? hintText,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: labelStyle,
      errorStyle: errorStyle,
      enabledBorder: styles.borderTextField,
      focusedBorder: styles.borderTextField,
      errorBorder: styles.borderTextField,
      focusedErrorBorder: styles.borderTextField,
    );
  }
}
