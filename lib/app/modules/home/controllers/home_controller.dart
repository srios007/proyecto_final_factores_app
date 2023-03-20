import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/user_model.dart';
import 'package:proyecto_final_factores_app/app/routes/app_pages.dart';
import 'package:proyecto_final_factores_app/app/services/services.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  late User user;

  @override
  onInit() async {
    await getData();
    super.onInit();
  }

  getData() async {
    print('get data');
    isLoading.value = true;
    user = (await userService.getCurrentUser())!;
    isLoading.value = false;
  }

  /// Cerrar sesion
  signOut() {
    auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  /// Va al perfil del cliente
  goToProfile() => Get.toNamed(Routes.PROFILE);

  /// Va a la pantalla de métodos de pago
  goToPaymentsMethods() {
    Get.toNamed(Routes.CREDIT_CARDS_LIST);
  }

}
