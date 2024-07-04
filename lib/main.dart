import 'package:ecom_mvvm/di/injection.dart';
import 'package:ecom_mvvm/services/routes/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  DependencyInjector.inject();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ecommerce',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
      // home: const LoginScreen(),
    );
  }
}
