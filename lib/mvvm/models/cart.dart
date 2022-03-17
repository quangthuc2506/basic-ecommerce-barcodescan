import 'dart:convert';
import 'package:get/get.dart';

class Cart {
  // async variable
  String? email;
  String? idSanPham;
  String? idDonHang;
  int? soLuong;
  // local variable
  RxBool? check = false.obs;
  RxInt? soLuongLocal = 1.obs; // so luong hien thi o may khach hang
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
