import 'package:ecommerce_qrcode/mvvm/models/product.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/cart_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/home_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/sign_in_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/widgets/dialog_sign_out.dart';
import 'package:ecommerce_qrcode/mvvm/widgets/product_card.dart';
import 'package:ecommerce_qrcode/routes/route_name.dart';
import 'package:ecommerce_qrcode/values/app_assets.dart';
import 'package:ecommerce_qrcode/values/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  SignInViewModel signInViewModel = Get.find(tag: 'signInViewModel');
  HomeViewModel homeViewModel =  Get.put(HomeViewModel(), tag: 'homeViewModel', permanent: true);
  CartViewModel cartViewModel = Get.put(CartViewModel(), tag: 'cartViewModel');

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = signInViewModel.getUser();
    RxList<dynamic> categories = homeViewModel.categories;
    RxList<dynamic> products = homeViewModel.products;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Center(
          child: Padding(
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
                    Get.delete<CartViewModel>(tag: 'cartViewModel');
                  },
                );
              },
            ),
          )
        ],
      ),
      bottomSheet: SizedBox(
        height: 73,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: SizedBox(
            width: 56,
            height: 56,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Image.asset(
                AppAssets.iconQR,
              ),
              onPressed: () {
                Get.toNamed(RouteName.barcodeScreen);
              },
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(right: 25, left: 25, bottom: 73),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Everything in your\ndoor step",
                      style: AppStyles.s30w700black),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 0.416,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xffF2C94C),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: RichText(
                          text: const TextSpan(
                              text: "Stay home\nwe deliver\n",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                  color: Colors.white),
                              children: [
                            TextSpan(
                                text: "Any where... Any time!!",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))
                          ])),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Image.asset(AppAssets.banner)),
                  ],
                ),
              ),
              Obx(
                () => (categories.isNotEmpty && products.isNotEmpty)
                    ? ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: homeViewModel.categories.length,
                        itemBuilder: ((context, indexLSP) {
                          RxList<dynamic> productsById = homeViewModel
                              .getProductsById(categories[indexLSP].idLSP);
                          return Obx(
                            () => Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text(categories[indexLSP].tenLSP,
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: productsById.isEmpty
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : GridView.builder(
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
                                            Product product =
                                                productsById[index];
                                            return ProductCart(
                                              onTap: () {
                                                Get.toNamed(
                                                    RouteName
                                                        .detailProductScreen,
                                                    arguments: product);
                                              },
                                              onPressAdd: () {
                                                Get.find<CartViewModel>(
                                                        tag: 'cartViewModel')
                                                    .addToCart(
                                                        idSP: product.idSP!);
                                              },
                                              name: product.tenSP,
                                              price: product.giaSP,
                                              image: FadeInImage.assetNetwork(
                                                image: product.hinhAnhSP!,
                                                placeholder:
                                                    AppAssets.gifloading,
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              ],
                            ),
                          );
                        }),
                      )
                    : const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: CircularProgressIndicator(),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
