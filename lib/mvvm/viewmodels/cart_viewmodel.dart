import 'dart:convert';

import 'package:ecommerce_qrcode/mvvm/models/cart.dart';
import 'package:ecommerce_qrcode/mvvm/models/product.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/home_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/sign_in_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/widgets/snackbar_error.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartViewModel extends GetxController {
  HomeViewModel homeViewModel = Get.find(tag: 'homeViewModel');
  SignInViewModel signInViewModel = Get.find(tag: 'signInViewModel');

  String? email;

  //// check so luong san pham
  RxInt total = 0.obs; // tong so luong mua

  RxDouble totalMoney = 0.0.obs;
  RxDouble shipFee = 10.0.obs;
  RxDouble totalPrice = 0.0.obs;
  //tang so luong moi san pham
  decreaseQuantity(RxInt quantity, Product product) {
    if (quantity > 0 && total > 0) {
      quantity--;
      totalMoney.value -= product.giaSP!;
      totalPrice.value -= product.giaSP!;
      total--;
    }
  }

  //giam so luong moi san pham
  increaseQuantity(RxInt quantity, Product product) {
    quantity++;
    totalMoney.value += product.giaSP!;
    totalPrice.value += product.giaSP!;
    total++;
  }
  ////

  //// check choose product
  // check chon tat ca san pham
  var checkAll = false.obs;

  onCheckAll() {
    checkAll.value = !checkAll.value;
    if (checkAll.isTrue) {
      totalMoney.value = 0.0;
      totalPrice.value = 0.0 + shipFee.value;
    }

    for (Cart i in _carts) {
      if (checkAll.isTrue) {
        i.check!.value = checkAll.value;
        totalMoney.value +=
            getProductById(i.idSanPham!).giaSP! * i.soLuongLocal!.toInt();
        totalPrice.value +=
            getProductById(i.idSanPham!).giaSP! * i.soLuongLocal!.toInt();
      } else {
        i.check!.value = checkAll.value;
        totalMoney.value -=
            getProductById(i.idSanPham!).giaSP! * i.soLuongLocal!.toInt();
        totalPrice.value -=
            getProductById(i.idSanPham!).giaSP! * i.soLuongLocal!.toInt();
      }
    }

    // if (checkAll.isTrue) {
    //   for (Cart i in _carts) {
    //     i.check!.value = checkAll.value;
    //   }
    // } else {
    //   for (var i in _carts) {
    //     i.check.value = checkAll.value;
    //   }
    // }
  }

  //check chon tung san pham
  onCheckProduct(RxBool checkProduct, Product product, RxInt quantity) {
    bool testAll = false;
    checkProduct.value = !checkProduct.value;
    if (checkProduct.isFalse) {
      checkAll.value = false;
      totalMoney.value -= product.giaSP! * quantity.toInt();
      totalPrice.value -= product.giaSP! * quantity.toInt();
    } else {
      totalMoney.value += product.giaSP! * quantity.toInt();
      totalPrice.value += product.giaSP! * quantity.toInt();
    }
    for (var i in _carts) {
      if (i.check.value == false) {
        testAll = false;
        break;
      } else {
        testAll = true;
      }
    }
    if (testAll == true) {
      checkAll.value = true;
    }
  }
  ////

  onCheckFavorite(RxBool checkFavorite) {
    checkFavorite.value = !checkFavorite.value;
  }

  @override
  void onInit() {
    email = signInViewModel.currentUser!.email;
    getCartsData(email!);
    super.onInit();
  }


  bool checkIdExist(RxList<dynamic> productsPara, String?id){
    
    for(Product pr in productsPara){
      if(pr.idSP == id){
        return true;
      }
    }
    return false;
  }
  addToCart(String? idSP) async {
  var _products = homeViewModel.products;
    bool validationID = checkIdExist(_products, idSP);
    
    String idDonHang = _carts[_carts.length-1].idDonHang+1.toString();
    if (validationID == true) {
      var jsonCart = {
        'email': email,
        'idSanPham': idSP,
        'soLuong': 1,
        'idDonHang': idDonHang
      };
      // chuyen json sang cart va add vao local
      Cart cart = Cart.fromJson(jsonCart);
      _carts.add(cart);

      // add item len database
      try {
        final url =
            Uri.parse("https://62216ed9afd560ea69b0255d.mockapi.io/donHang");
        final response = await http.post(url,
            headers: {"Content-type": "application/json"},
            body: json.encode(jsonCart),
            encoding: Encoding.getByName("utf8-8"));
        print(response.body);
        return 'true';
      } catch (e) {
        print(e.toString());
      }
    } else {
      SnackbarError().showSnackbarError();
      return 'false';
    }
    // set item can add
  }

  onDeleteCartById(String idDonHang) async {
    // delete local
    
    var carts1 = List.from(_carts);
    print("id don hang: $idDonHang");
    for (Cart item in carts1) {
      if (item.idDonHang == idDonHang) {
        _carts.remove(item);
      }
    }
    // delete database
    try {
      final url = Uri.parse(
          "https://62216ed9afd560ea69b0255d.mockapi.io/donHang/$idDonHang");
      final response = await http.delete(url);
      print(response.body);
      return true;
    } catch (e) {
      return false;
    }
  }

  final RxList<dynamic> _carts = [].obs;
  RxList<dynamic> get carts => _carts;
  getCartsData(String email) async {
    try {
      final url =
          Uri.parse('https://62216ed9afd560ea69b0255d.mockapi.io/donHang');
      final response = await http.get(url);
      if (200 == response.statusCode) {
        String source = const Utf8Decoder().convert(response.bodyBytes);
        var sourceCarts = Cart().cartListModelFromJson(source);
        _carts.clear();
        totalPrice.value = shipFee.value;
        for (Cart item in sourceCarts) {
          if (item.email == email) {
            total.value += item.soLuong!; // tong so luong san pham ban dau
            item.soLuongLocal!.value =
                item.soLuong!; // cap nhat so luong san pham
            
            _carts.add(item);
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Product getProductById(String? idSP) {
    Product? reach;
    // lay danh sach tat ca san pham
    var products2 = homeViewModel.products;
    for (Product pro in products2) {
      print("id can tim: $idSP");

      if (pro.idSP == idSP) {
        print("id cua san pham tuong ung: ${pro.idSP}");
        reach = pro;
        break;
      }
    }
    return reach!;
  }
}