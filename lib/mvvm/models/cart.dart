import 'dart:convert';
import 'package:get/get.dart';

class Cart {
  // async variable
  String? email;
  String? idSanPham;
  String? idDonHang;
  int? soLuong; // quantity was saved in the database
  // local variable
  RxBool? check = false.obs;
  RxInt? currentQuantity = 1.obs; // quantity is showing in the cart now
  Cart({this.email, this.idSanPham, this.soLuong, this.idDonHang, this.check});
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      email: json['email'],
      idSanPham: json['idSanPham'],
      idDonHang: json['idDonHang'],
      soLuong: json['soLuong'],
      check: false.obs);
  List<Cart> cartListModelFromJson(String str) =>
      List<Cart>.from(jsonDecode(str).map((x) => Cart.fromJson(x)));
}
