import 'package:ecommerce_qrcode/mvvm/models/product.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/cart_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  CartViewModel cartViewModel = Get.find(tag: 'cartViewModel');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: cartViewModel.checkAll.value,
                          activeColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onChanged: (value) {
                            cartViewModel.onCheckAll();
                          }),
                    ),
                    Obx(
                      () => Text(
                        "All (${cartViewModel.total} products)",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.green,
                    ))
              ],
            ),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 270),
                child: SingleChildScrollView(
                  child: Obx(
                    () => cartViewModel.carts.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cartViewModel.carts.length,
                            itemBuilder: (context, index) {
                              // lay product o vi tri index
                              Product product = cartViewModel.getProductById(
                                  cartViewModel.carts[index].idSanPham);
                              return CardInCart(
                                product: product,
                                checkProduct: cartViewModel.carts[index].check,
                                quantity:
                                    cartViewModel.carts[index].soLuongLocal,
                                onPressedDelete: () {
                                  cartViewModel.onDeleteCartById(
                                      cartViewModel.carts[index].idDonHang);
                                },
                              );
                            }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            thickness: 1,
            height: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Enter Your Coupon",
                      prefixIcon: const Icon(
                        Icons.discount,
                        color: Colors.green,
                      ),
                      suffixIcon: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Apply"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10)))),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 0.25, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 0.25, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Card(
                    margin: EdgeInsets.zero,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 0.5, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(
                                  () => Text(
                                    "Item(${cartViewModel.carts.length})",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff9098B1)),
                                  ),
                                ),
                                Obx(
                                  () => Text(
                                      "\$${cartViewModel.totalMoney.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Shipping",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff9098B1)),
                                ),
                                Obx(
                                  () => Text("\$${cartViewModel.shipFee}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Price",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black),
                                ),
                                Obx(
                                  () => Text(
                                      "\$${cartViewModel.totalPrice.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.green)),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Obx(() => Text(
                        "Pay \$${cartViewModel.totalPrice.toStringAsFixed(2)}")),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fixedSize: Size(MediaQuery.of(context).size.width, 50)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardInCart extends StatelessWidget {
  CartViewModel cartViewModelQuantity = Get.find(tag: 'cartViewModel');
  Product? product;
  RxBool? checkProduct;
  RxBool? checkFavorite = false.obs;
  RxInt? quantity;
  Function()? onPressedDelete;
  CardInCart(
      {Key? key,
      this.product,
      this.onPressedDelete,
      this.checkProduct,
      this.quantity})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        cartViewModelQuantity.onCheckProduct(
            checkProduct!, product!, quantity!);
      },
      child: Card(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        elevation: 0,
        shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.25, color: Colors.grey),
            borderRadius: BorderRadius.circular(5)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Obx(
                () => Checkbox(
                    activeColor: Colors.green,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    value: checkProduct!.value,
                    onChanged: (value) {
                      cartViewModelQuantity.onCheckProduct(
                          checkProduct!, product!, quantity!);
                    }),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[300],
                ),
                margin: const EdgeInsets.only(top: 16, bottom: 16, right: 8),
                padding: const EdgeInsets.all(8),
                width: 72,
                height: 72,
                child: Image.network(product!.hinhAnhSP!),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            product!.tenSP!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        Row(
                          children: [
                            Obx(
                              () => IconButton(
                                  onPressed: () {
                                    cartViewModelQuantity
                                        .onCheckFavorite(checkFavorite!);
                                  },
                                  icon: checkFavorite!.value
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.pink,
                                        )
                                      : const Icon(
                                          Icons.favorite_border,
                                          color: Colors.grey,
                                        )),
                            ),
                            IconButton(
                                onPressed: onPressedDelete,
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.grey,
                                ))
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${product!.giaSP!.toString()}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.green),
                        ),
                        SizedBox(
                          width: 108,
                          height: 38,
                          child: Obx(
                            () => TextFormField(
                              enableInteractiveSelection: false,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                              onChanged: (value) {
                                TextEditingController(text: value);
                              },
                              controller: TextEditingController(
                                text: quantity.toString(),
                              ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                                prefixIcon: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    cartViewModelQuantity.decreaseQuantity(
                                        quantity!, product!);
                                  },
                                ),
                                suffixIcon: IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: const Icon(
                                      Icons.add,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      cartViewModelQuantity.increaseQuantity(
                                          quantity!, product!);
                                      // setState(() {
                                      //   amount++;
                                      // });
                                    }),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffEFEFEF)),
                                    borderRadius: BorderRadius.circular(30)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffEFEFEF)),
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
