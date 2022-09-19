import 'package:flutter/material.dart';
import 'package:todo_app_getx/constants/dimensions.dart';

double height = 0.0;
double width = 0.0;

const kSnackbarDuration = 1500;

//* empty sized box with only width
const kEmptySizedBox = SizedBox();
const kW4sizedBox = SizedBox(width: kSmallPaddingUnit);
const kW8sizedBox = SizedBox(width: kSmallPaddingUnit * 2);
const kW12sizedBox = SizedBox(width: kSmallPaddingUnit * 3);
const kW16sizedBox = SizedBox(width: kSmallPaddingUnit * 4);
const kW20sizedBox = SizedBox(width: kSmallPaddingUnit * 5);

//* empty sized box with only height
const kH4sizedBox = SizedBox(height: kSmallPaddingUnit);
const kH8sizedBox = SizedBox(height: kSmallPaddingUnit * 2);
const kH12sizedBox = SizedBox(height: kSmallPaddingUnit * 3);
const kH16sizedBox = SizedBox(height: kSmallPaddingUnit * 4);
const kH20sizedBox = SizedBox(height: kSmallPaddingUnit * 5);

//* border radius widget
BorderRadius k5BorderRadius = BorderRadius.circular(kRadius5);
BorderRadius k10BorderRadius = BorderRadius.circular(kRadius10);
