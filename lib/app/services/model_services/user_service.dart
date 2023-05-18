import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import 'package:proyecto_final_factores_app/app/models/user_model.dart';
import 'package:proyecto_final_factores_app/app/services/services.dart';
import 'package:proyecto_final_factores_app/app/utils/utils.dart';

class UserService {
  factory UserService() {
    return _instance;
  }

  UserService._internal();
  static String usersReference = firebaseReferences.users;
  static final UserService _instance = UserService._internal();
  var firestore = FirebaseFirestore.instance;

  //Para paginacion
  DocumentSnapshot? lastDocument;

  Future<bool> save({
    required User user,
    required String customId,
  }) async {
    try {
      user.created = DateTime.now();
      await database.saveUserWithCustom(
        user.toJson(),
        usersReference,
        customId,
      );
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> delete(User user) async {
    try {
      await database.deleteDocument(user.id!, usersReference);
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> update(User user) async {
    try {
      final DocumentReference docRef = database.getDocumentReference(
        collection: usersReference,
        documentId: user.id!,
      );

      await docRef.update(user.toJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateUserClient({
    required String collectionDocumentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await database.updateFirst(
        collectionDocumentId,
        usersReference,
        'client',
        data,
      );
      return true;
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  Future<User?> getCurrentUser() async {
    final currentFirebaseUser = auth.getCurrentUser();
    final user = await getUserDocumentById(
      currentFirebaseUser!.uid,
    );
    return user;
  }

  Future<User?> getUserDocumentById(
    String documentId,
  ) async {
    final querySnapshot = await database.getDocument(
      collection: 'users',
      documentId: documentId,
    );

    if (!querySnapshot.exists) return null;

    return User.fromJson(
      querySnapshot.data() as Map<String, dynamic>,
    );
  }

  Future<bool> validateLogin() async {
    User user = User();
    user = (await getCurrentUser())!;
    if (user.role!.contains('client')) {
      return true;
    } else {
      await auth.signOut();
      return false;
    }
  }

  getShops() async {
    RxList shops = [].obs;
    final querySnapshot = await database.getDataByCustonParam(
      ['shop'],
      usersReference,
      'role',
    );
    if (querySnapshot.docs.isEmpty) return [];

    for (final shop in querySnapshot.docs) {
      shops.add(User.fromJson(
        shop.data() as Map<String, dynamic>,
      ));
    }
    return shops;
  }
}

UserService userService = UserService();
