import 'package:get/get.dart';

import 'package:proyecto_final_factores_app/app/modules/product_detail/controllers/product_detail_controller.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(
      () => ProductDetailController(),
    );
  }
}
