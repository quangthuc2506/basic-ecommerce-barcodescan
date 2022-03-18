import 'package:ecommerce_qrcode/mvvm/viewmodels/barcode_scanner_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class BarcodeScannerScreen extends StatefulWidget {
   BarcodeScannerScreen({Key? key}) : super(key: key);
  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  var barcodeController = Get.put(BarcodeScannerViewModel(), tag: 'barcodeScannerViewModel');
  @override
  void initState() {
    super.initState();
    _startCamera();
  }

  @override
  void dispose() {
    barcodeController.camController!.dispose();
    super.dispose();
  }
  
  Future _startCamera() async {
    barcodeController.camController?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      barcodeController.camController?.startImageStream(barcodeController.processCameraImage);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!barcodeController.camController!.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Barcode Scanner'),
            centerTitle: true,
          ),
          body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: CameraPreview(barcodeController.camController!))),
      debugShowCheckedModeBanner: false,
    );
  }
}
