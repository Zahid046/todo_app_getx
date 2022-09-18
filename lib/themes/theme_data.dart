import 'package:flutter/material.dart';
import 'package:todo_app_getx/constants/colors.dart';
import 'package:todo_app_getx/constants/dimensions.dart';
import 'package:todo_app_getx/constants/styles.dart';
import 'package:todo_app_getx/constants/values.dart';

ThemeData themeData = ThemeData(
  splashColor: cPlaceHolderColor.withOpacity(.3),
  hoverColor: cPlaceHolderColor.withOpacity(.3),
  splashFactory: InkSplash.splashFactory,
  iconTheme: IconThemeData(size: height > kSmallDeviceSizeLimit ? kIconSize20 : kIconSize16, color: cIconColor),
  scaffoldBackgroundColor: cWhiteColor,
  textButtonTheme: TextButtonThemeData(style: buttonStyle(cBrandColor)),
  elevatedButtonTheme: ElevatedButtonThemeData(style: kElevatedButtonStyle),
  // textTheme: TextTheme(), //todo:: setup text theme
  primaryColor: cBrandColor,
  disabledColor: cPlaceHolderColor,
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: f14TextStyle(cPlaceHolderColor, FontWeight.w400),
    hintStyle: f14TextStyle(cPlaceHolderColor, FontWeight.w400),
    floatingLabelStyle: kFloatingLabelStyle,
    errorStyle: kErrorInputTextStyle,
  ),
  fontFamily: 'Poppins',
);
