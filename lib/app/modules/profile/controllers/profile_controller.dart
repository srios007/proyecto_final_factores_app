import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/models.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  late User user;
  @override
  void onInit() {
    user = Get.arguments['user'];
   
    super.onInit();
  }
}
