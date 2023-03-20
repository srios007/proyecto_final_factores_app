import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/modules/my_shopping/controllers/my_shopping_controller.dart';

class MyShoppingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyShoppingController>(
      () => MyShoppingController(),
    );
  }
}
