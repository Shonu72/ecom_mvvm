import 'package:ecom_mvvm/core/utils/helpers.dart';
import 'package:ecom_mvvm/presentation/views/Auth/login_screen.dart';
import 'package:ecom_mvvm/presentation/views/Auth/signup_screen.dart';
import 'package:ecom_mvvm/presentation/views/Profiles/payment_method.dart';
import 'package:ecom_mvvm/presentation/views/Profiles/show_address_screen.dart';
import 'package:ecom_mvvm/presentation/views/checkout/address.dart';
import 'package:ecom_mvvm/presentation/views/checkout/checkout_page.dart';
import 'package:ecom_mvvm/presentation/views/checkout/order_success_screen.dart';
import 'package:ecom_mvvm/presentation/views/main_page.dart';
import 'package:ecom_mvvm/presentation/views/products/home_screen.dart';
import 'package:ecom_mvvm/presentation/views/products/product_details_screen.dart';
import 'package:ecom_mvvm/presentation/views/products/widgets/all_prodcts_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
    redirect: (context, state) async {
      bool? isLoggedIn = await Helper.getUser(key: 'isLoggedIn');
      int initialIndex = 0; // Replace 0 with your dynamic value
      if (isLoggedIn == true && state.uri.toString() == '/') {
        return '/mainpage/$initialIndex';
      } else if (isLoggedIn == false && state.uri.toString() != '/') {
        return '/';
      }

      return null;
    },
    initialLocation: '/',
    routes: [
      GoRoute(
        name: 'login',
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: 'register',
        path: '/register',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
          name: 'mainpage',
          path: '/mainpage/:initialIndex',
          builder: (context, state) {
            final initialIndex =
                int.parse(state.pathParameters['initialIndex']!);
            return MainPage(initialIndex: initialIndex);
          }),
      GoRoute(
        name: 'homepage',
        path: '/homepage',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: 'productdetails',
        path: '/productdetails/:productId',
        builder: (BuildContext context, GoRouterState state) {
          return ProductDetailsScreen(
            productId: int.parse(state.pathParameters['productId']!),
          );
        },
      ),
      GoRoute(
        name: 'allproducts',
        path: '/allproducts',
        builder: (context, state) {
          return const AllProductScreen();
        },
      ),
      GoRoute(
        name: 'address',
        path: '/address',
        builder: (context, state) => const AddressPage(),
      ),
      GoRoute(
        name: 'checkout',
        path: '/checkout',
        builder: (context, state) => const CheckoutPage(),
      ),
      GoRoute(
        name: 'ordersuccess',
        path: '/ordersuccess',
        builder: (context, state) => const OrderSuccessScreen(),
      ),
      GoRoute(
        name: 'orderfailure',
        path: '/orderfailure',
        builder: (context, state) => const OrderFailedScreen(),
      ),
      GoRoute(
        name: 'showaddress',
        path: '/showaddress',
        builder: (context, state) => const ShowAddressScreen(),
      ),
      GoRoute(
        name: 'showcardscreen',
        path: '/showcardscreen',
        builder: (context, state) => const ShowCardScreen(),
      ),
    ]);
