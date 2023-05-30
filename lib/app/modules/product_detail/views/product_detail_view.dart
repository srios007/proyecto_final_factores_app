import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
        buttonText: 'Agregar al carrito',
        isLoading: false.obs,
        onPressed: controller.addToCart,
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
          'Precio',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Palette.mainBlue,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          constants.numberFormat.format(
            controller.product.price,
          ),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Stock disponible',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Palette.mainBlue,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          '${controller.product.stock}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
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
}
