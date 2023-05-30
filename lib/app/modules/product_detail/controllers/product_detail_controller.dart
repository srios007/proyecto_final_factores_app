import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/models.dart';
import 'package:proyecto_final_factores_app/app/modules/home/controllers/home_controller.dart';
import 'package:proyecto_final_factores_app/app/widgets/widgets.dart';

class ProductDetailController extends GetxController {
  Product product = Get.arguments['product'];
  HomeController homeController = Get.find();
  String id = Get.arguments['id'];
  RxBool isLoading = false.obs;

  addToCart() {
    if (product.stock! > 0) {
      final shopCart = ShoppingCartModel(stock: 1.obs);
      shopCart.product = product;
      homeController.shoppingCart.add(shopCart);
      Get.back();
      CustomSnackBars.showSuccessSnackBar(
        'Produto agregado al carrito con éxito',
      );
    } else {
      CustomSnackBars.showErrorSnackBar(
        'No hay stock de este producto',
      );
    }
  }
}
