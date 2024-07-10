import 'package:ecom_mvvm/core/themes/colors.dart';
import 'package:ecom_mvvm/presentation/views/Auth/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _showButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: Lottie.asset(
                'assets/animations/pay.json',
                height: 600,
                width: 600,
                repeat: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _showButton
              ? Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      backgroundColor: primaryColor,
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        // side: const BorderSide(color: primaryColor),
                      ),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             const MainPage(initialIndex: 0)));

                      context.pushNamed('mainpage', pathParameters: {
                        'initialIndex': '0',
                      });
                    },
                    child: const AppText(
                        text: "Continue Shopping", color: Colors.white),
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 60)
        ],
      ),
    );
  }
}

class OrderFailedScreen extends StatefulWidget {
  const OrderFailedScreen({super.key});

  @override
  State<OrderFailedScreen> createState() => _OrderFailedScreen();
}

class _OrderFailedScreen extends State<OrderFailedScreen> {
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _showButton = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: Lottie.asset(
                'assets/animations/payment_failed.json',
                height: 400,
                width: 400,
                repeat: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _showButton
              ? Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      backgroundColor: primaryColor,
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      // context,
                      // MaterialPageRoute(
                      //     builder: (context) =>
                      //         const MainPage(initialIndex: 0)));
                      context.pushNamed('mainpage', pathParameters: {
                        'initialIndex': '0',
                      });
                    },
                    child: const AppText(
                        text: "Continue Shopping", color: Colors.white),
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(height: 60)
        ],
      ),
    );
  }
}
