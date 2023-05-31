import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/models.dart';
import 'package:proyecto_final_factores_app/app/models/purchase_model.dart';
import 'package:proyecto_final_factores_app/app/modules/home/controllers/home_controller.dart';
import 'package:proyecto_final_factores_app/app/services/services.dart';

class MyShoppingController extends GetxController {
  final homeController = Get.find<HomeController>();
  RxBool isLoading = false.obs;
  RxList purchases = [].obs;
  late User user;

  @override
  onInit() async {
    await getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    user = homeController.user;
    purchases = await purchasesService.getPurchasesByUserId(user.id!);
    print(purchases.length);

    isLoading.value = false;
  }
}
