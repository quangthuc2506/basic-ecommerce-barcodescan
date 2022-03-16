import 'package:ecommerce_qrcode/mvvm/models/product.dart';
import 'package:ecommerce_qrcode/mvvm/views/cart_screen.dart';
import 'package:ecommerce_qrcode/mvvm/views/detail_product_screen.dart';
import 'package:ecommerce_qrcode/mvvm/views/home_screen.dart';
import 'package:ecommerce_qrcode/mvvm/views/signin_screen.dart';
import 'package:flutter/material.dart';

class Routercontrol {
  static Route generateRoute(RouteSettings settings ){
    switch (settings.name) {
      case 'SignInScreen':
        return MaterialPageRoute(builder: (context)=> SignInScreen());
      case 'HomeScreen':
      return MaterialPageRoute(builder: (context)=>HomeScreen());
      case 'DetailProductScreen': 
      {
        Product product = settings.arguments as Product;
      return MaterialPageRoute(builder: (context)=> DetailProductScreen(product: product,));
      }
      case 'CartScreen': 
      return MaterialPageRoute(builder: (context)=> CartScreen());
      default:
      return MaterialPageRoute(builder: (_){
        return Scaffold(
          body: Center(child: Text("No route defined for${settings.name}"),),
        );
      });
    }
  }
}