import 'package:flutter/material.dart';
import 'package:proyecto_final_factores_app/app/modules/home/controllers/home_controller.dart';
import 'package:proyecto_final_factores_app/app/utils/utils.dart';
import 'package:proyecto_final_factores_app/app/widgets/widgets.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Image.asset(
                  imageReferences.logo,
                  height: 80,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Techmart',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Palette.mainBlue,
                  ),
                )
              ],
            ),
          ),
          ItemMenu(
            iconData: Icons.shopping_bag_outlined,
            text: 'Productos',
            onTap: controller.goToProducts,
          ),
          ItemMenu(
            iconData: Icons.shop_outlined,
            text: 'Tiendas',
            onTap: controller.goToShops,
          ),
          ItemMenu(
            iconData: Icons.shopping_cart_checkout_sharp,
            text: 'Mis compras',
            onTap: controller.goToShopping,
          ),
          ItemMenu(
            iconData: Icons.person_2_outlined,
            text: 'Perfil',
            onTap: controller.goToProfile,
          ),
          ItemMenu(
            iconData: Icons.payment_outlined,
            text: 'Métodos de pago',
            onTap: controller.goToPaymentsMethods,
          ),
          const Spacer(),
          ItemMenu(
            iconData: Icons.exit_to_app,
            text: 'Cerrar Sesión',
            onTap: controller.signOut,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
