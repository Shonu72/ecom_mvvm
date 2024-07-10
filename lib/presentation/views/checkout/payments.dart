import 'package:ecom_mvvm/core/utils/helpers.dart';
import 'package:ecom_mvvm/presentation/getx/controllers/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentHelper {
  late Razorpay _razorpay;
  final BuildContext context;

  PaymentHelper(this.context) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  final CartController cartController = Get.find<CartController>();
  void openCheckout(double amount) {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': (amount * 100).toInt(),
      'name': 'hCommerce',
      'description': 'Payment for your orders',
      'prefill': {'contact': '1234567890', 'email': 'test@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error : $e.toString()');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint('Payment success');
    Helper.toast("Payment Success: ${response.paymentId!}");
    cartController.clearCart();
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => const OrderSuccessScreen()));

    context.push('/ordersuccess');
  }

  void handlePaymentError(PaymentFailureResponse response) {
    debugPrint('Payment Failure');
    Helper.toast("Payment Failed: ${response.message!}");
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => const OrderFailedScreen()));
    context.push('/orderfailure');
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    debugPrint('Payment success');
    Fluttertoast.showToast(
        msg: "External Wallet: ${response.walletName!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void dispose() {
    _razorpay.clear();
  }
}
