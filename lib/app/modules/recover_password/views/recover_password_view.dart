import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/modules/recover_password/controllers/recover_password_controller.dart';

class RecoverPasswordView extends GetView<RecoverPasswordController> {
  const RecoverPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RecoverPasswordView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RecoverPasswordView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
