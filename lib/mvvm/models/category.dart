import 'dart:convert';

class Category {
  String? idLSP;
  String? tenLSP;
  
  Category({this.idLSP,this.tenLSP});
  factory Category.fromJson(Map<String,dynamic> json) => Category(
    idLSP: json['idLSP'],
    tenLSP: json['tenLSP']
  );

  static List<Category> categoryListModelFromJson(String str){
    return List<Category>.from(jsonDecode(str).map((x)=> Category.fromJson(x)));
  }

}