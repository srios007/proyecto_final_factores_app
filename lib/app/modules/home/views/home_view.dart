import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/modules/home/controllers/home_controller.dart';
import 'package:proyecto_final_factores_app/app/modules/home/widgets/drawer_home.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      drawer: DrawerHome(controller: controller),
      body: const Center(
        child: Text(
          'HomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
