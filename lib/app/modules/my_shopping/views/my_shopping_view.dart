import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/modules/my_shopping/controllers/my_shopping_controller.dart';

class MyShoppingView extends GetView<MyShoppingController> {
  const MyShoppingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShoppingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MyShoppingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
