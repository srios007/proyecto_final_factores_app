import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/product_model.dart';

import 'package:proyecto_final_factores_app/app/services/services.dart';
import 'package:proyecto_final_factores_app/app/utils/utils.dart';
import 'package:proyecto_final_factores_app/app/widgets/widgets.dart';

class ProductsService {
  factory ProductsService() {
    return _instance;
  }
  ProductsService._internal();
  static String productsReference = firebaseReferences.products;
  static final ProductsService _instance = ProductsService._internal();
  var firestore = FirebaseFirestore.instance;

  getAllProducts() async {
    RxList products = [].obs;
    final querySnapshot = await database.getData(productsReference);
    if (querySnapshot.docs.isEmpty) return [];

    for (final product in querySnapshot.docs) {
      products.add(Product.fromJson(
        product.data() as Map<String, dynamic>,
      ));
    }
    return products;
  }

  Future<RxList> getProductsByShop(String shopId) async {
    RxList products = [].obs;
    final querySnapshot = await database.getDataByCustonParam(
      shopId,
      productsReference,
      'shopId',
    );

    if (querySnapshot.docs.isEmpty) return [].obs;
    // print('si hay');
    for (final product in querySnapshot.docs) {
      products.add(Product.fromJson(
        product.data() as Map<String, dynamic>,
      ));
    }
    return products;
  }

  updateProduct({
    required String productId,
    required Product data,
  }) async {
    try {
      await database.updateDocument(
        productId,
        data.toJson(),
        productsReference,
      );
    } on Exception catch (e) {
      CustomSnackBars.showErrorSnackBar(
        'Hubo un error al actualizar el producto',
      );
      print(e);
      return false;
    }
  }
}

ProductsService productsService = ProductsService();
