import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:proyecto_final_factores_app/app/models/models.dart';
import 'package:proyecto_final_factores_app/app/modules/home/widgets/drawer_home.dart';
import 'package:proyecto_final_factores_app/app/modules/shops/controllers/shops_controller.dart';
import 'package:proyecto_final_factores_app/app/routes/app_pages.dart';
import 'package:proyecto_final_factores_app/app/utils/utils.dart';
import 'package:proyecto_final_factores_app/app/widgets/widgets.dart';

class ShopsView extends GetView<ShopsController> {
  const ShopsView({super.key});
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
          'Tiendas',
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
          : controller.shops.isEmpty
              ? noResults()
              : productsGrid(),
    );
  }

  productsGrid() {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: controller.shops.length,
          (BuildContext context, int index) {
            final shop = controller.shops[index];
            return shopsItem(shop);
          },
        ),
      ),
    );
  }

  shopsItem(User user) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.SHOP_DETAIL, arguments: {'user': user});
      },
      child: Container(
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
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  filterQuality: FilterQuality.none,
                  imageUrl: user.profilePictureUrl!,
                  width: Get.width,
                  height: 150,
                  fit: BoxFit.cover,
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
                'Tienda ${user.name!}',
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
