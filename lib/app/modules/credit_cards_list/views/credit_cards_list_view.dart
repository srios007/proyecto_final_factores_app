import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_final_factores_app/app/models/models.dart';
import 'package:proyecto_final_factores_app/app/modules/credit_cards_list/controllers/credit_cards_list_controller.dart';
import 'package:proyecto_final_factores_app/app/utils/utils.dart';
import 'package:proyecto_final_factores_app/app/widgets/widgets.dart';

class CreditCardsListView extends GetView<CreditCardsListController> {
  const CreditCardsListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mis tarjetas',
          style: TextStyle(color: Palette.mainBlue),
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomButton(
        width: Get.width - 60,
        isLoading: false.obs,
        onPressed: controller.goToAddCard,
        buttonText: 'Agregar tarjeta',
      ),
      body: CustomScrollView(
        slivers: [
          Obx(
            () => controller.isLoading.value
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: LoadingWidget(),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final child = controller.cards[index];
                        return childrenCard(child, index);
                      },
                      childCount: controller.cards.length, // 1000 list items
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  childrenCard(CreditCard child, int position) {
    const titleStyle = TextStyle(
      color: Palette.mainBlue,
      fontWeight: FontWeight.bold,
    );
    return Padding(
      padding: EdgeInsets.only(
          bottom: controller.cards.length == position + 1 ? 90 : 0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Tarjeta', style: titleStyle),
            const SizedBox(height: 10),
            Text(
              '************${child.cardNumber!.substring(
                child.cardNumber!.length - 4,
                child.cardNumber!.length,
              )}',
            ),
          ],
        ),
      ),
    );
  }
}
