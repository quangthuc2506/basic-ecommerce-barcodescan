import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarError{
  showSnackbarError(){
    Get.showSnackbar(const GetSnackBar(
        messageText: Text(
          "Mã sản phẩm không hợp lệ, vui lòng thử lại!",
          style: TextStyle(color: Colors.black),
        ),
        
        backgroundColor: Color.fromARGB(255, 76, 175, 80),
        duration: Duration(seconds: 5),
      ));
  }
}