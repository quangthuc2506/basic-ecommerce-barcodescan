import 'package:ecommerce_qrcode/barcode/barcode_detector.dart';
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
  BarcodeScanner? barcodeScanner;
  var cartViewModel = Get.find<CartViewModel>(tag: 'cartViewModel');
  var homeViewModel = Get.find<HomeViewModel>(tag: 'homeViewModel');
  bool isBusy = false;
  CustomPaint? customPaint;

  @override
  void initState() {
    print("init");
    barcodeScanner = GoogleMlKit.vision.barcodeScanner();
    super.initState();
  }

  @override
  void dispose() {
    print("disspose");
    barcodeScanner!.close();
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
    List<Barcode> barcodes = await barcodeScanner!.processImage(inputImage);
    print('Found ${barcodes.length} barcodes');

    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null &&
        barcodes.isNotEmpty) {
      String valueId = barcodes[0].value.displayValue!.trim();
      // kiem tra du lieu scan duoc co trong bang id san pham khong
      bool checkExist =
          cartViewModel.checkIdExist(homeViewModel.products, valueId);
      if (checkExist == true) {
        Product product = cartViewModel.getProductById(valueId);
        cartViewModel.addToCart(idSP: valueId.trim());
        isBusy = true;

        barcodes.clear();

        Get.offNamed(RouteName.detailProductScreen, arguments: product);

        return;
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
