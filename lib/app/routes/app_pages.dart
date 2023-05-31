import 'package:get/get.dart';

import '../modules/add_credit_card/bindings/add_credit_card_binding.dart';
import '../modules/add_credit_card/views/add_credit_card_view.dart';
import '../modules/credit_cards_list/bindings/credit_cards_list_binding.dart';
import '../modules/credit_cards_list/views/credit_cards_list_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/my_shopping/bindings/my_shopping_binding.dart';
import '../modules/my_shopping/views/my_shopping_view.dart';
import '../modules/product_detail/bindings/product_detail_binding.dart';
import '../modules/product_detail/views/product_detail_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/recover_password/bindings/recover_password_binding.dart';
import '../modules/recover_password/views/recover_password_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/shopDetail/bindings/shop_detail_binding.dart';
import '../modules/shopDetail/views/shop_detail_view.dart';
import '../modules/shopping_cart/bindings/shopping_cart_binding.dart';
import '../modules/shopping_cart/views/shopping_cart_view.dart';
import '../modules/shops/bindings/shops_binding.dart';
import '../modules/shops/views/shops_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.CREDIT_CARDS_LIST,
      page: () => const CreditCardsListView(),
      binding: CreditCardsListBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.ADD_CREDIT_CARD,
      page: () => AddCreditCardView(),
      binding: AddCreditCardBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL,
      page: () => const ProductDetailView(),
      binding: ProductDetailBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.RECOVER_PASSWORD,
      page: () => const RecoverPasswordView(),
      binding: RecoverPasswordBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.SHOPS,
      page: () => const ShopsView(),
      binding: ShopsBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.SHOP_DETAIL,
      page: () => const ShopDetailView(),
      binding: ShopDetailBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.SHOPPING_CART,
      page: () => const ShoppingCartView(),
      binding: ShoppingCartBinding(),
      transition: Transition.native,
    ),
    GetPage(
      name: _Paths.MY_SHOPPING,
      page: () => const MyShoppingView(),
      binding: MyShoppingBinding(),
    ),
  ];
}
