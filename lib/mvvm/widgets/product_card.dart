import 'package:flutter/material.dart';

class ProductCart extends StatelessWidget {
  ProductCart({Key? key, this.name, this.price, this.image,this.onTap,this.onPressAdd}) : super(key: key);
  String? name = "";
  double? price = 1;
  Widget? image;
  Function()? onTap;
  Function()? onPressAdd;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(width: 1, color: Color(0xffE5E5E5))),
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                child: ConstrainedBox(
                  child: Stack(children: [
                    ClipOval(
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            color: const Color.fromARGB(255, 247, 225, 161),
                            child: ClipOval(
                              child: Container(
                                color: const Color(0xffF2C94C),
                              ),
                            ))),
                    Positioned(right: 0, left: 0, bottom: -10, child: image!)
                  ]),
                  constraints: const BoxConstraints(maxHeight: 90, maxWidth: 90),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    Text(
                      "by weight \$${price!.toString()}",
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ],
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
                            fontSize: 14,
                            color: Colors.black),
                        children: [
                          TextSpan(
                              text: price!.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: Colors.black))
                        ]),
                  ),
                  Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.green),
                      child: IconButton(
                        onPressed: onPressAdd,
                        icon: const Icon(Icons.add),
                        padding: EdgeInsets.zero,
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
