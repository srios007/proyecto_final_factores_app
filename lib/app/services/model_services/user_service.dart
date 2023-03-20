import 'package:cloud_firestore/cloud_firestore.dart';

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
}

UserService userService = UserService();
