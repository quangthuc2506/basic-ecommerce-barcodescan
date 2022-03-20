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
  BarcodeScannerViewModel barcodeScannerViewModel = Get.put(BarcodeScannerViewModel(), tag: 'barcodeScannerViewModel');


  ////////////////////////////////////////////// don't touch  ^^
  @override
  void initState() {
    super.initState();
    _startCamera();
  }
  
  Future _startCamera() async {
    barcodeScannerViewModel.camController?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      barcodeScannerViewModel.camController?.startImageStream(barcodeScannerViewModel.processCameraImage);
      setState(() {});
    });
  }
  ////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    if (!barcodeScannerViewModel.camController!.value.isInitialized) {
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
              child: CameraPreview(barcodeScannerViewModel.camController!))),
      debugShowCheckedModeBanner: false,
    );
  }
}
