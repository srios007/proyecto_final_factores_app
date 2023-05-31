import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/models.dart';
import 'package:proyecto_final_factores_app/app/routes/app_pages.dart';
import 'package:proyecto_final_factores_app/app/services/services.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList products = [].obs;
  RxList shoppingCart = [].obs;
  late User user;

  @override
  onInit() async {
    await getData();
    super.onInit();
  }

  getData() async {
    isLoading.value = true;
    user = (await userService.getCurrentUser())!;
    products = await productsService.getAllProducts();
    print(products.length);
    isLoading.value = false;
  }

  /// Cerrar sesion
  signOut() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  /// Va al perfil del cliente
  goToProfile() {
    Get.back();
    Get.toNamed(Routes.PROFILE, arguments: {'user': user});
  }

  /// Va a la pantalla de métodos de pago
  goToPaymentsMethods() {
    Get.back();
    Get.toNamed(Routes.CREDIT_CARDS_LIST, arguments: {'id': user.id});
  }

  /// Va a la pantalla de tiendas
  goToShops() {
    Get.back();
    Get.toNamed(Routes.SHOPS);
  }

  /// Va a la pantalla de tiendas
  goToProducts() {
    Get.back();
    Get.toNamed(Routes.HOME);
  }

  /// Va a la pantalla de mis compras
  goToShopping() {
    Get.back();
    Get.toNamed(Routes.MY_SHOPPING);
  }

  /// Va a la pantalla de detalle del producto
  goToProductDetail(Product product) {
    Get.toNamed(Routes.PRODUCT_DETAIL, arguments: {
      'product': product,
      'id': user.id,
    });
  }

  /// Va al carrito de compras
  goToCart() {
    Get.toNamed(Routes.SHOPPING_CART);
  }
}
