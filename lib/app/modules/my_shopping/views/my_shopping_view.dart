import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proyecto_final_factores_app/app/models/purchase_model.dart';
import 'package:proyecto_final_factores_app/app/modules/home/widgets/drawer_home.dart';
import 'package:proyecto_final_factores_app/app/modules/my_shopping/controllers/my_shopping_controller.dart';
import 'package:proyecto_final_factores_app/app/utils/utils.dart';
import 'package:proyecto_final_factores_app/app/widgets/widgets.dart';

class MyShoppingView extends GetView<MyShoppingController> {
  const MyShoppingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => controller.isLoading.value
            ? const SizedBox.shrink()
            : Text(
                'Bienvenido ${controller.user.name}',
                style: const TextStyle(color: Palette.black, fontSize: 16),
              )),
        centerTitle: true,
      ),
      drawer: DrawerHome(controller: controller.homeController),
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            titleSection(),
            productsSection(),
          ],
        ),
      ),
    );
  }

  titleSection() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'Mis compras',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  productsSection() {
    return Obx(
      () => controller.isLoading.value
          ? loadingWidget()
          : controller.purchases.isEmpty
              ? noResults()
              : purchasesList(),
    );
  }

  purchasesList() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final purchase = controller.purchases[index];

            return shopsItem(purchase);
          },
          childCount: controller.purchases.length, // 1000 list items
        ),
      ),
    );
  }

  shopsItem(Purchase purchase) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 300,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                filterQuality: FilterQuality.none,
                imageUrl: purchase.productUrl!,
                width: Get.width,
                height: 170,
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
            const Spacer(flex: 2),
            Text(
              purchase.productName!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Text(
              'Cantidad que compraste: ${purchase.stock!}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const Spacer(),
            Text(
              'Estado: ${purchase.state}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  noResults() {
    return const SliverToBoxAdapter(
      child: Center(
        child: Text('Sin resultados'),
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
}
