import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/modules/credit_cards_list/controllers/credit_cards_list_controller.dart';

class CreditCardsListView extends GetView<CreditCardsListController> {
  const CreditCardsListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreditCardsListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CreditCardsListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
