import 'package:ecom_mvvm/presentation/views/Auth/login_screen.dart';
import 'package:ecom_mvvm/presentation/views/Auth/signup_screen.dart';
import 'package:ecom_mvvm/presentation/views/products/home.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: '/', routes: [
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
    name: 'homepage',
    path: '/homepage',
    builder: (context, state) => const HomePage(),
  ),
]);
