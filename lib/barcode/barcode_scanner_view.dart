import 'package:ecommerce_qrcode/barcode/barcode_detector.dart';
import 'package:ecommerce_qrcode/main.dart';
import 'package:ecommerce_qrcode/mvvm/models/product.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/cart_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/home_viewmodel.dart';
import 'package:ecommerce_qrcode/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'camera_view.dart';

class BarcodeScannerView extends StatefulWidget {
  @override
  _BarcodeScannerViewState createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  BarcodeScanner barcodeScanner = GoogleMlKit.vision.barcodeScanner();
  var cartViewModel = Get.find<CartViewModel>(tag: 'cartViewModel');
  var homeViewModel = Get.find<HomeViewModel>(tag: 'homeViewModel');
  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void dispose() {
    barcodeScanner.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Barcode Scanner',
      customPaint: customPaint,
      onImage: (inputImage) {
        processImage(inputImage);
      },
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;
    String? valueId = "";
    final barcodes = await barcodeScanner.processImage(inputImage);
    print('Found ${barcodes.length} barcodes');
    if (inputImage.inputImageData?.size != null &&
            inputImage.inputImageData?.imageRotation != null ||
        barcodes.isNotEmpty) {
      for (final Barcode barcode in barcodes) {
        valueId = barcode.value.displayValue!.trim();
        break;
      }

      if (barcodes.isNotEmpty) {
        print("du lieu scan duoc: ${valueId}");
        homeViewModel.getProductData();
        bool checkExist =
            cartViewModel.checkIdExist(homeViewModel.products, valueId);
        if (checkExist == true) {
          Product product = cartViewModel.getProductById(valueId);

          cartViewModel.addToCart(valueId!.trim());
          print("value ID scanned : $valueId");
          print("value type : ${valueId.runtimeType}");

          print("productId : ${product.idSP}");
          print("productId type : ${product.idSP.runtimeType}");

          print(
              "so sanh product Id : ${product.idSP!.trim() == valueId.trim()}");

          Get.offAndToNamed(RouteName.detailProductScreen, arguments: product);
          return;
        }
      }

      final painter = BarcodeDetectorPainter(
          barcodes,
          inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
