import 'package:ecommerce_qrcode/mvvm/viewmodels/barcode_scanner_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/cart_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/home_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/sign_in_viewmodel.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInViewModel());
    Get.lazyPut(() => HomeViewModel(), tag: 'homeViewModel', fenix: false);
    Get.lazyPut(() => CartViewModel(), tag: 'cartViewModel',fenix: true);
    Get.lazyPut(() => BarcodeScannerViewModel(), tag: 'barcodeScannerViewModel');
  }
}
