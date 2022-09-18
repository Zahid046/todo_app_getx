
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  

  // show alert dialog
  Future<dynamic> showAlertDialog({context, child}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => child,
    );
  }

}
