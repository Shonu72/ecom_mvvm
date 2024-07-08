import 'package:ecom_mvvm/core/utils/helpers.dart';
import 'package:ecom_mvvm/presentation/views/Auth/login_screen.dart';
import 'package:ecom_mvvm/presentation/views/Auth/signup_screen.dart';
import 'package:ecom_mvvm/presentation/views/main_page.dart';
import 'package:ecom_mvvm/presentation/views/products/home_screen.dart';
import 'package:ecom_mvvm/presentation/views/products/product_details_screen.dart';
import 'package:ecom_mvvm/presentation/views/products/widgets/all_prodcts_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
    redirect: (context, state) async {
      bool? isLoggedIn = await Helper.getUser(key: 'isLoggedIn');
      const loggedInPath = '/mainpage:/index';
      if (isLoggedIn == true) {
        return loggedInPath;
      } else if (isLoggedIn == false && state.matchedLocation != '/') {
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
          path: '/mainpage:/index',
          builder: (context, state) {
            final initialIndex =
                int.parse(state.queryParameters['index'] ?? '0');
            return MainPage(initialIndex: initialIndex);
          }),
      GoRoute(
        name: 'homepage',
        path: '/homepage',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        name: 'productdetails',
        path: '/productdetails/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ProductDetailsScreen(productId: id);
        },
      ),
      GoRoute(
        name: 'allproducts',
        path: '/allproducts',
        builder: (context, state) {
          return const AllProductScreen();
        },
      ),
    ]);
