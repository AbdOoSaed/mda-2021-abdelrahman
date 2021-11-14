import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(
    {@required String? message, Color backgroundColor = Colors.black}) {
  if (message == null || message.isEmpty) return;

  //light vibration to let the user focus on what happened
  HapticFeedback.lightImpact();

  Fluttertoast.cancel(); //remove old toasts

  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 4,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0);
}
