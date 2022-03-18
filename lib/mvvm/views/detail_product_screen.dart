import 'package:ecommerce_qrcode/mvvm/models/product.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/cart_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/home_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/sign_in_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/widgets/dialog_sign_out.dart';
import 'package:ecommerce_qrcode/mvvm/widgets/product_card.dart';
import 'package:ecommerce_qrcode/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class DetailProductScreen extends StatelessWidget {
  Product? product;
  DetailProductScreen({Key? key, this.product}) : super(key: key);

  SignInViewModel signInViewModel = Get.find(tag: 'signInViewModel');
  HomeViewModel homeViewModel = Get.find(tag: 'homeViewModel');
  CartViewModel cartViewModel = Get.find<CartViewModel>(tag: 'cartViewModel');
  RxInt? quantity = 1.obs;

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = signInViewModel.getUser();
    var productsById = homeViewModel.getProductsById(product!.idLSP!);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: () {
              Get.toNamed(RouteName.cartScreen);
            },
            icon: Icon(
              Icons.shopping_cart_rounded,
              color: Colors.green[600],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: SizedBox(
                  width: 30,
                  height: 30,
                  child: GoogleUserCircleAvatar(identity: user!)),
              onPressed: () {
                showDialogSignOut(
                  context,
                  user,
                  () {
                    signInViewModel.signOut();
                    Get.offNamedUntil(RouteName.signInScreen, (route) => false);
                  },
                );
              },
            ),
          )
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(right: 25, left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                  child: ConstrainedBox(
                    child: Stack(children: [
                      ClipOval(
                          child: Container(
                              padding: const EdgeInsets.all(20),
                              color: const Color.fromARGB(255, 247, 225, 161),
                              child: ClipOval(
                                child: Container(
                                  color: const Color(0xffF2C94C),
                                ),
                              ))),
                      Positioned(
                          bottom: -15,
                          left: 0,
                          right: 0,
                          child: Image.network(product!.hinhAnhSP!))
                    ]),
                    constraints:
                        const BoxConstraints(maxHeight: 168, maxWidth: 168),
                  ),
                ),
              ),
              Center(
                child: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    width: 246,
                    height: 100,
                    child: SfBarcodeGenerator(
                      value: product!.idSP,
                      showValue: true,
                      symbology: Code128(),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product!.tenSP!,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      const Text(
                        "by Farm fresh veg shop",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffBDBDBD)),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.star,
                      color: Colors.yellow[700],
                    ),
                    label: const Text(
                      "4.7",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                                width: 1, color: Color(0xffEFEFEF)))),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: Text(
                  product!.moTaSP!,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff4F4F4F)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "\$",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                            color: Colors.black),
                        children: [
                          TextSpan(
                              text: product!.giaSP!.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Colors.black))
                        ]),
                  ),
                  SizedBox(
                    width: 108,
                    height: 38,
                    child: Obx(
                      () => TextFormField(
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        controller: TextEditingController(
                          text: quantity.toString(),
                        ),
                        onChanged: (value) {
                          TextEditingController(text: value);
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              if (quantity!.value > 0) {
                                quantity!.value--;
                              }
                            },
                          ),
                          suffixIcon: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                quantity!.value++;
                              }),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xffEFEFEF)),
                              borderRadius: BorderRadius.circular(30)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xffEFEFEF)),
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print("so luong: ${quantity!.value}");
                      cartViewModel.addToCart(
                          idSP: product!.idSP!, soLuong: quantity!.value);
                      Get.toNamed(RouteName.cartScreen);
                    },
                    child: const Text(
                      "Buy now",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(112, 36),
                        primary: const Color(0xff6FCF97),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24))),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Divider(thickness: 1),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                      "Similar Products",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Obx(
                    () => GridView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.6923,
                              crossAxisSpacing: 25,
                              mainAxisSpacing: 25),
                      itemCount: productsById.length,
                      itemBuilder: (context, index) {
                        Product product = productsById[index];
                        return ProductCart(
                          onPressAdd: () {
                            Get.find<CartViewModel>(tag: 'cartViewModel')
                                .addToCart(idSP: product.idSP!);
                          },
                          onTap: () {
                            Get.toNamed(RouteName.detailProductScreen,
                                arguments: product);
                          },
                          name: product.tenSP,
                          price: product.giaSP,
                          image: Image.network(product.hinhAnhSP!),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
