import 'package:ecommerce_qrcode/mvvm/viewmodels/sign_in_viewmodel.dart';
import 'package:ecommerce_qrcode/values/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
   SignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SignInViewModel signInViewModel = Get.put(SignInViewModel(),tag: 'signInViewModel',permanent: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const[
          Padding(
            padding: EdgeInsets.only(right: 16,top: 10),
            child: Text("Skip",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w600)),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.background), fit: BoxFit.fill)),
                
        child: Padding(
          padding: const EdgeInsets.only(left: 32,right: 32,bottom: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text("Explore Together",style: TextStyle(fontSize: 36,fontWeight: FontWeight.w600),),
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                    "Create an account to run wild through our curated experiences",textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 16,fontWeight: FontWeight.w400
                    ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: buttonWith(
                    logo: Image.asset(AppAssets.logoGoogle),
                    label: "Continue with Google",
                    onPressed: () {
                      signInViewModel.signIn();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: buttonWith(
                    logo: Image.asset(AppAssets.logoAple),
                    label: "Continue with Apple",
                    onPressed: () {}),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80,top: 12),
                child: buttonWith(
                    logo: SizedBox(child: Image.asset(AppAssets.logoEmail)),
                    label: "Continue with Email",
                    onPressed: () {}),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buttonWith({Function()? onPressed, Widget? logo, String? label}) {
  return ElevatedButton.icon(
      onPressed: onPressed!,
      icon: Padding(
        padding: const EdgeInsets.only(bottom: 15,top: 15,right: 10),
        child: logo!,
      ),
      style: ElevatedButton.styleFrom(
          fixedSize:const Size(311, 55),
          primary: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
      label: Text(
        label!,
        style:const TextStyle(
            fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black),
      ));
}
