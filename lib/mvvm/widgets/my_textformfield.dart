import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final Icon? icon;
  final Widget? label;
  final String? hintText;
  bool obsText = true;
  final String? Function(String?)? validator;
  final GestureDetector? suffixIcon;
  final Function(String?)? onchanged;
  MyTextFormField(
      {Key? key, this.icon,
      this.label,
      this.hintText,
      this.obsText = false,
      this.validator,
      this.onchanged,
      this.suffixIcon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obsText,
      onChanged: onchanged,
      decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(30.0)),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(30.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.blue)),
          prefixIcon: icon,
          suffixIcon: suffixIcon,
          label: label,
          hintText: hintText,
          floatingLabelStyle: const TextStyle(color: Colors.blue)),
    );
  }
}
