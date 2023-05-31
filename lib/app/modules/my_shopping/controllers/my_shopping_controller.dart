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
    await getPurchases();
    print(purchases.length);

    isLoading.value = false;
  }

  /// Trae los purchases del usuario
  getPurchases() async {
    database
        .getCollectionSnapshotQuery('purchases', 'clientId', user.id!)
        .listen((event) async {
      if (event.docs.isNotEmpty) {
        isLoading.value = true;

        purchases = [].obs;
        for (final purchase in event.docs) {
          purchases.add(
            Purchase.fromJson(
              purchase.data() as Map<String, dynamic>,
              isGet: true,
            ),
          );
        }
        isLoading.value = false;
      }
    });
  }
}
