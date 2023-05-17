import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/routes/app_pages.dart';
import 'package:proyecto_final_factores_app/app/services/services.dart';
import 'package:proyecto_final_factores_app/app/widgets/widgets.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final key = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool showPass = false.obs;

  /// Muestra u oculta la contraseña
  showPassword() {
    showPass.value = !showPass.value;
  }

  /// Va a la pestaña de registro
  goToRegister() {
    Get.toNamed(Routes.REGISTER);
  }

  /// Va a recuperar contraseña
  forgotPass() {}

  /// Inicia sesión
  login() async {
    if (key.currentState!.validate()) {
      isLoading.value = true;

      try {
        final response = await auth.signIn(
            email: emailController.text.trim(), password: passController.text);
        if (response is! String) {
          final result = await userService.validateLogin();
          if (result) {
            Get.offAllNamed(Routes.HOME);
          } else {
            CustomSnackBars.showErrorSnackBar(
              'No tienes acceso a esta plataforma',
            );
          }
          isLoading.value = false;
        } else {
          CustomSnackBars.showErrorSnackBar(response);
          isLoading.value = false;
        }
      } catch (e) {
        e.toString();
      }
    }
  }
}
