import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/models.dart';
import 'package:proyecto_final_factores_app/app/modules/home/controllers/home_controller.dart';
import 'package:proyecto_final_factores_app/app/services/model_services/user_service.dart';

class ShopsController extends GetxController {
  final homeController = Get.find<HomeController>();
  RxBool isLoading = false.obs;
  RxList shops = [].obs;
  late User user;

  @override
  onInit() async {
    await getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    user = homeController.user;
    shops = await userService.getShops();
    print(shops.length);
    isLoading.value = false;
  }
}
