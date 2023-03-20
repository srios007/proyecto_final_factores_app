import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/utils/palette.dart';

class CutomSnackBars {
  static showSuccessSnackBar(String message) => Get.showSnackbar(
        GetSnackBar(
          title: '¡Listo!',
          message: message,
          duration: const Duration(seconds: 3),
          backgroundColor: Palette.green,
        ),
      );
  static showErrorSnackBar(String message) => Get.showSnackbar(
        GetSnackBar(
          title: 'Error',
          message: message,
          duration: const Duration(seconds: 3),
        ),
      );
    static showNotificationSnackBar(String message) => Get.showSnackbar(
        GetSnackBar(
          message: message,
          duration: const Duration(seconds: 3),
          // backgroundColor: Palette.purple,
        ),
      );
}
