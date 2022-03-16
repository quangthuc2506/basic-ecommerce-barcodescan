import 'dart:math';

import 'package:ecommerce_qrcode/mvvm/viewmodels/cart_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/home_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/sign_in_viewmodel.dart';
import 'package:get/get.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignInViewModel());
    Get.lazyPut(() => HomeViewModel());
    // Get.create(() => CartViewModel());
    Get.lazyPut(() => CartViewModel(),tag: 'cartViewModel',fenix: true);
  }
}