import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/models.dart';
import 'package:proyecto_final_factores_app/app/modules/home/controllers/home_controller.dart';
import 'package:proyecto_final_factores_app/app/widgets/widgets.dart';

class ProductDetailController extends GetxController {
  Product product = Get.arguments['product'];
  RxBool isLoading = false.obs;
  String id = Get.arguments['id'];

  HomeController homeController = Get.find();

  pay() {
    final shopCart = ShoppingCartModel(stock: 1.obs);
    shopCart.product = product;
    // if (card != null) {
    homeController.shoppingCart.add(shopCart);
    Get.back();
    CustomSnackBars.showSuccessSnackBar(
        'Produto agregado al carrito con éxito');
    // }
    // else {
    //   CustomSnackBars.showErrorSnackBar(
    //     'Por favor, agrega o escoge una tarjeta de crédito',
    //   );
    // }
  }
}
