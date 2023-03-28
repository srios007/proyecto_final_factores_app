import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proyecto_final_factores_app/app/models/credit_card_model.dart';
import 'package:proyecto_final_factores_app/app/modules/product_detail/controllers/product_detail_controller.dart';
import 'package:proyecto_final_factores_app/app/utils/utils.dart';
import 'package:proyecto_final_factores_app/app/widgets/widgets.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.product.name!,
          style: const TextStyle(
            color: Palette.mainBlue,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: CustomButton(
        buttonText: 'Comprar por ${constants.numberFormat.format(
          controller.product.price,
        )}',
        isLoading: false.obs,
        onPressed: controller.pay,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        bottom: true,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageSection(),
                    descriptionSection(),
                  ],
                ),
              ),
            ),
            Obx(
              () => controller.isLoading.value
                  ? loadingWidget()
                  : controller.cards.isEmpty
                      ? addPaymenthMethodButton()
                      : creditCardList(),
            ),
          ],
        ),
      ),
    );
  }

  creditCardList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final child = controller.cards[index];
          return childrenCard(child, index);
        },
        childCount: controller.cards.length, // 1000 list items
      ),
    );
  }

  addPaymenthMethodButton() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: CustomButton(
          width: Get.width,
          isLoading: false.obs,
          onPressed: controller.goToAddCard,
          buttonText: 'Agregar método de pago',
        ),
      ),
    );
  }

  loadingWidget() {
    return const SliverToBoxAdapter(
      child: Center(
        child: LoadingWidget(),
      ),
    );
  }

  descriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          'Descripción del producto',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Palette.mainBlue,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          controller.product.description!,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),
        const Text(
          'Método de pago',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Palette.mainBlue,
          ),
        ),
      ],
    );
  }

  imageSection() {
    return CachedNetworkImage(
      filterQuality: FilterQuality.none,
      imageUrl: controller.product.imageUrl!,
      width: Get.width,
      height: 300,
      fit: BoxFit.contain,
      progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: LoadingAnimationWidget.twistingDots(
            leftDotColor: Palette.mainBlue,
            rightDotColor: Palette.green,
            size: 20,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  childrenCard(CreditCard child, int position) {
    const titleStyle = TextStyle(
      color: Palette.mainBlue,
      fontWeight: FontWeight.bold,
    );
    return Obx(() => GestureDetector(
          onTap: () {
            controller.selectCard(child);
          },
          child: Padding(
            padding: EdgeInsets.only(
                bottom: controller.cards.length == position + 1 ? 90 : 0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(
                  color: child.isSelected!.value
                      ? Palette.mainBlue
                      : Colors.transparent,
                ),
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
          ),
        ));
  }
}
