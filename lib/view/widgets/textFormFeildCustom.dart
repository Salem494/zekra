// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';


class InputDecorations {
  // ignore: non_constant_identifier_names
  static InputDecoration buildInputDecoration_1(String hint_text,IconData icon) {
    return InputDecoration(
        hintText: hint_text,
        hintStyle: TextStyle(fontSize: 12.0),
        prefixIcon: Icon(icon,color: Colors.black,size: 22,),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.5),
          borderRadius: const BorderRadius.all(
            const Radius.circular(5.0),
          ),
        ),
    );
  }
}

