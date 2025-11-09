import 'package:flutter/material.dart';

void displayErrorMsg(String message, BuildContext context) {
  showDialog(context: context, builder: (context) => AlertDialog(
    title: Text(message),
  ));
}
