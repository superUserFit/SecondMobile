import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UseToast {
  static void showToast({
    required String message,
    dynamic title,
    dynamic status,
    dynamic position
  }) {
    dynamic toastColor;
    dynamic toastPosition;

    switch(status) {
      case 'success':
        toastColor = Colors.green;
        break;

      case 'error':
        toastColor = Colors.red;
        break;

      default:
        toastColor = Colors.grey;
        break;
    }

    switch(position) {
      case 'TOP':
        toastPosition = ToastGravity.TOP;
        break;

      case 'BOTTOM':
        toastPosition = ToastGravity.BOTTOM;
        break;

      case 'CENTER':
        toastPosition = ToastGravity.CENTER;
        break;

      default:
        toastPosition = ToastGravity.BOTTOM;
        break;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: toastPosition,
      timeInSecForIosWeb: 1,
      backgroundColor: toastColor,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
