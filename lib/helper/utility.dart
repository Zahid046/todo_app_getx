import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/constants/colors.dart';
import 'package:todo_app_getx/constants/values.dart';


void heightWidth(context) {
  height = MediaQuery.of(context).size.height;
  width = MediaQuery.of(context).size.width;
}

void ll(message) {
  log(message.toString());
}

  void errorSnackBar(title, message, duration) {
    Get.snackbar(
      title,
      message,
      backgroundColor: cErrorColor,
      colorText: cWhiteColor,
      maxWidth: 400,
      duration: Duration(milliseconds: duration),
    );
  }

  void warningSnackBar(title, message, duration) {
    Get.snackbar(
      title,
      message,
      backgroundColor: cWarningColor,
      colorText: cWhiteColor,
      maxWidth: 400,
      duration: Duration(milliseconds: duration),
    );
  }

  void successSnackBar(title, message, duration) {
    Get.snackbar(
      title,
      message,
      backgroundColor: cSuccessColor,
      colorText: cWhiteColor,
      maxWidth: 400,
      duration: Duration(milliseconds: duration),
    );
  }

  void infoSnackBar(title, message, duration) {
    Get.snackbar(
      title,
      message,
      backgroundColor: cInfoColor,
      colorText: cWhiteColor,
      maxWidth: 400,
      duration: Duration(milliseconds: duration),
    );
  }

  void notificationSnackBar(title, message, duration) {
    Get.snackbar(
      title,
      message,
      maxWidth: 400,
      duration: Duration(milliseconds: duration),
    );
  }
