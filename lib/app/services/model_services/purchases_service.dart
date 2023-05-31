import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/product_model.dart';
import 'package:proyecto_final_factores_app/app/models/purchase_model.dart';

import 'package:proyecto_final_factores_app/app/services/services.dart';
import 'package:proyecto_final_factores_app/app/utils/utils.dart';

class PurchasesService {
  factory PurchasesService() {
    return _instance;
  }
  PurchasesService._internal();
  static String purchaseReference = firebaseReferences.purchases;
  static final PurchasesService _instance = PurchasesService._internal();
  var firestore = FirebaseFirestore.instance;

  // getAllProducts() async {
  //   RxList products = [].obs;
  //   final querySnapshot = await database.getData(productsReference);
  //   if (querySnapshot.docs.isEmpty) return [];

  //   for (final product in querySnapshot.docs) {
  //     products.add(Product.fromJson(
  //       product.data() as Map<String, dynamic>,
  //     ));
  //   }
  //   return products;
  // }

  Future<RxList> getPurchasesByUserId(String clientId) async {
    RxList purchases = [].obs;
    final querySnapshot = await database.getDataByCustonParam(
      clientId,
      purchaseReference,
      'clientId',
    );

    if (querySnapshot.docs.isEmpty) return [].obs;
    // print('si hay');
    for (final purchase in querySnapshot.docs) {
      purchases.add(Purchase.fromJson(
        purchase.data() as Map<String, dynamic>,
        isGet: true,
      ));
    }
    return purchases;
  }

  Future<bool> addPurchase({
    required Purchase purchase,
  }) async {
    try {
      await database.saveDocumentInCollection(
        collection: purchaseReference,
        collectionData: purchase.toJson(),
      );

      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }
}

PurchasesService purchasesService = PurchasesService();
