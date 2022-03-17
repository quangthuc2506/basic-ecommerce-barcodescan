import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarCustom {
  static showSnackbarError(String content) {
    Get.showSnackbar(GetSnackBar(
      messageText: Text(
        content,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: const Color.fromARGB(255, 76, 175, 80),
      duration: const Duration(seconds: 2),
    ));
  }
}
