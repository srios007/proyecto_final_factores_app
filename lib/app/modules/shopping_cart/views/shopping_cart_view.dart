import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proyecto_final_factores_app/app/models/models.dart';
import 'package:proyecto_final_factores_app/app/modules/shopping_cart/controllers/shopping_cart_controller.dart';
import 'package:proyecto_final_factores_app/app/utils/utils.dart';
import 'package:proyecto_final_factores_app/app/widgets/widgets.dart';

class ShoppingCartView extends GetView<ShoppingCartController> {
  const ShoppingCartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carrito de compras',
          style: TextStyle(color: Palette.black, fontSize: 16),
        ),
      ),
      floatingActionButton: CustomButton(
        buttonText: 'Pagar',
        isLoading: controller.isLoading,
        onPressed: controller.pay,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        bottom: true,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 30, 20),
                child: Text(
                  'Medio de pago',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Palette.mainBlue,
                  ),
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
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 30, 30, 20),
                child: Text(
                  'Productos',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Palette.mainBlue,
                  ),
                ),
              ),
            ),
            Obx(
              () => controller.isLoading.value
                  ? loadingWidget()
                  : controller.homeController.shoppingCart.isEmpty
                      ? noProducts()
                      : productsList(),
            ),
          ],
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

  noProducts() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Center(
          child: Text('No has agregado productos aún'),
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

  productsList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final cartItem = controller.homeController.shoppingCart[index];
          return cartItemWidget(cartItem, index);
        },
        childCount:
            controller.homeController.shoppingCart.length, // 1000 list items
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

  childrenCard(CreditCard child, int position) {
    const titleStyle = TextStyle(
      color: Palette.mainBlue,
      fontWeight: FontWeight.bold,
    );
    return Obx(() => GestureDetector(
          onTap: () {
            controller.selectCard(child);
          },
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
        ));
  }

  cartItemWidget(ShoppingCartModel cart, int position) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 150,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  filterQuality: FilterQuality.none,
                  imageUrl: cart.product!.imageUrl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Padding(
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
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: Get.width * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cart.product!.name!,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      '${constants.numberFormat.format(cart.product!.price)} C/U',
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      children: [
                        buttonAddLessStock(
                            onTap: () {
                              controller.addLessStock(false, cart);
                            },
                            label: '-'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '${cart.stock!.value}',
                            textAlign: TextAlign.start,
                          ),
                        ),
                        buttonAddLessStock(
                          onTap: () {
                            controller.addLessStock(true, cart);
                          },
                          label: '+',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => controller.deleteItem(position),
                child: const Icon(
                  Icons.delete,
                  color: Palette.red,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buttonAddLessStock({
    required VoidCallback onTap,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text(label)),
      ),
    );
  }
}
