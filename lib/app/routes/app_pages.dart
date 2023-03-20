import 'package:get/get.dart';

import 'package:proyecto_final_factores_app/app/modules/add_credit_card/bindings/add_credit_card_binding.dart';
import 'package:proyecto_final_factores_app/app/modules/add_credit_card/views/add_credit_card_view.dart';
import 'package:proyecto_final_factores_app/app/modules/credit_cards_list/bindings/credit_cards_list_binding.dart';
import 'package:proyecto_final_factores_app/app/modules/credit_cards_list/views/credit_cards_list_view.dart';
import 'package:proyecto_final_factores_app/app/modules/home/bindings/home_binding.dart';
import 'package:proyecto_final_factores_app/app/modules/home/views/home_view.dart';
import 'package:proyecto_final_factores_app/app/modules/login/bindings/login_binding.dart';
import 'package:proyecto_final_factores_app/app/modules/login/views/login_view.dart';
import 'package:proyecto_final_factores_app/app/modules/my_shopping/bindings/my_shopping_binding.dart';
import 'package:proyecto_final_factores_app/app/modules/my_shopping/views/my_shopping_view.dart';
import 'package:proyecto_final_factores_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:proyecto_final_factores_app/app/modules/profile/views/profile_view.dart';
import 'package:proyecto_final_factores_app/app/modules/register/bindings/register_binding.dart';
import 'package:proyecto_final_factores_app/app/modules/register/views/register_view.dart';

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
    ),
    GetPage(
      name: _Paths.CREDIT_CARDS_LIST,
      page: () => const CreditCardsListView(),
      binding: CreditCardsListBinding(),
    ),
    GetPage(
      name: _Paths.MY_SHOPPING,
      page: () => const MyShoppingView(),
      binding: MyShoppingBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CREDIT_CARD,
      page: () => AddCreditCardView(),
      binding: AddCreditCardBinding(),
    ),
  ];
}
