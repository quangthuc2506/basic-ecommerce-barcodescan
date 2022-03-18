import 'package:ecommerce_qrcode/mvvm/views/barcode_scanner_screen.dart';
import 'package:ecommerce_qrcode/mvvm/views/cart_screen.dart';
import 'package:ecommerce_qrcode/mvvm/views/detail_product_screen.dart';
import 'package:ecommerce_qrcode/mvvm/views/home_screen.dart';
import 'package:ecommerce_qrcode/mvvm/views/signin_screen.dart';
import 'package:ecommerce_qrcode/routes/route_name.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
    GetPage(name: RouteName.signInScreen, page: () => SignInScreen()),
    GetPage(name: RouteName.homeScreen, page: () => HomeScreen()),
    GetPage(name: RouteName.detailProductScreen, page: () => DetailProductScreen()),
    GetPage(name: RouteName.cartScreen, page: () => CartScreen()),
    GetPage(name: RouteName.barcodeScreen, page: () => BarcodeScannerScreen())
  ];
}
