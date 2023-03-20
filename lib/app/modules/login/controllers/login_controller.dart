import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/routes/app_pages.dart';

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
  login() {
    if (key.currentState!.validate()) {
      Get.offAllNamed(Routes.HOME);
    }
  }
}
