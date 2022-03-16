import 'dart:convert';

class Product {
  String? idLSP;
  String? idSP;
  String? tenSP;
  double? giaSP;
  String? hinhAnhSP;
  String? moTaSP;
  Product({this.idLSP,this.idSP,this.tenSP,this.giaSP,this.hinhAnhSP,this.moTaSP});
  factory Product.fromJson(Map<String,dynamic> json) => Product(
    idLSP: json['idLSP'],
    idSP: json['idSP'],
    tenSP: json['tenSP'],
    giaSP: json['giaSP'],
    hinhAnhSP: json['hinhAnhSP'],
    moTaSP: json['moTaSP']
  );

  static List<Product> productListModelFromJson(String str){
    return List<Product>.from(jsonDecode(str).map((x)=> Product.fromJson(x)));
  }

  

}
