import 'package:camera/camera.dart';
import 'package:ecommerce_qrcode/main.dart';
import 'package:ecommerce_qrcode/mvvm/models/product.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/cart_viewmodel.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/home_viewmodel.dart';
import 'package:ecommerce_qrcode/routes/route_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class BarcodeScannerViewModel extends GetxController {
  
  var cartViewModel = Get.find<CartViewModel>(tag: 'cartViewModel');
  var homeViewModel = Get.find<HomeViewModel>(tag: 'homeViewModel');
  CameraController? camController;
  BarcodeScanner? barcodeScanner = GoogleMlKit.vision.barcodeScanner();
  bool isBusy = false; 

  Future<void> processImage(InputImage inputImage) async {    
    if (isBusy) return;
    isBusy = true;
    List<Barcode> barcodes = await barcodeScanner!.processImage(inputImage);
    print('Found ${barcodes.length} barcodes');

    if (inputImage.inputImageData?.size != null && inputImage.inputImageData?.imageRotation != null && barcodes.isNotEmpty) {
      String valueId = barcodes[0].value.displayValue!.trim();
      // check data scanned is exist in the id table cart
      bool checkExist = cartViewModel.checkIdExist(homeViewModel.products, valueId);
      if (checkExist == true) {
        Product product = cartViewModel.getProductById(valueId);
        cartViewModel.addToCart(idSP: valueId.trim());
        isBusy = true;
        barcodes.clear();
        Get.offNamed(RouteName.detailProductScreen, arguments: product);
        return;
      }
    }
    isBusy = false;
  }
  
  Future processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();
    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());
    final camera = cameras![0];
    final imageRotation = InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ?? InputImageRotation.Rotation_0deg;

    final inputImageFormat = InputImageFormatMethods.fromRawValue(image.format.raw) ?? InputImageFormat.NV21;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
    processImage(inputImage);
  }

  @override
  void onClose() {
    barcodeScanner!.close();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    camController = CameraController(cameras![0], ResolutionPreset.max);
  }
}
