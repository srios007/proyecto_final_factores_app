import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/models.dart';
import 'package:proyecto_final_factores_app/app/modules/home/controllers/home_controller.dart';
import 'package:proyecto_final_factores_app/app/routes/app_pages.dart';
import 'package:proyecto_final_factores_app/app/services/services.dart';

class ShopDetailController extends GetxController {
  final homeController = Get.find<HomeController>();
  User shop = Get.arguments['user'];
  RxBool isLoading = false.obs;
  RxList products = [].obs;
  late User user;

  @override
  onInit() async {
    await getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    user = homeController.user;
    products = await productsService.getProductsByShop(shop.id!);
    isLoading.value = false;
  }

  goToProductDetail(Product product) {
    Get.toNamed(Routes.PRODUCT_DETAIL, arguments: {
      'product': product,
      'id': user.id,
    });
  }
}
