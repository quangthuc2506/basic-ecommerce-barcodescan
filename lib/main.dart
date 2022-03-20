import 'package:camera/camera.dart';
import 'package:ecommerce_qrcode/routes/app_routes.dart';
import 'package:ecommerce_qrcode/routes/route_name.dart';
import 'package:ecommerce_qrcode/mvvm/viewmodels/binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/smart_management.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

List<CameraDescription>? cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      smartManagement: SmartManagement.keepFactory,
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      initialRoute: RouteName.signInScreen,
      getPages: AppRoutes.pages,
    );
  }
}
