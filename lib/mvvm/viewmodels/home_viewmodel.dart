import 'dart:convert';
import 'package:ecommerce_qrcode/mvvm/models/category.dart';
import 'package:ecommerce_qrcode/mvvm/models/product.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends GetxController {
  @override
  void onInit() {
    getProductData();
    getCategoryData();
    
    super.onInit();
  }
  
  final RxList<dynamic> _products = [].obs;
  RxList<dynamic> get products => _products;

  getProductData() async {
    try {
      final url = Uri.parse('https://62216ed9afd560ea69b0255d.mockapi.io/SP');
      http.Response response = await http.get(url);
      
      if (200 == response.statusCode) {
        String source = const Utf8Decoder().convert(response.bodyBytes);
        
        List<Product> sourceProduct = Product.productListModelFromJson(source);
        _products.clear();
        for (Product item in sourceProduct) {
          _products.add(item);
        }
      }
      
    } catch (e) {
      e.printError();
    }
  }

  final RxList<dynamic> _categories = [].obs;
  RxList<dynamic> get categories => _categories;

  getCategoryData() async {
    try {
      final url = Uri.parse('http://62216ed9afd560ea69b0255d.mockapi.io/LoaiSP');
      http.Response response = await http.get(url);
      if (200 == response.statusCode) {
        String source = const Utf8Decoder().convert(response.bodyBytes);
        List<Category> sourceCategories = Category.categoryListModelFromJson(source);
        _categories.clear();
        for (Category item in sourceCategories) {
          _categories.add(item);
        }
      }
    } catch (e) {
      e.printError();
    }
  }


  RxList<dynamic> getProductsById(String id) {
    RxList<dynamic> _productsById = [].obs;
    for (Product ct in _products) {
      if (ct.idLSP == id) {
        _productsById.add(ct);
      }
    }
    return _productsById;
  }
}
