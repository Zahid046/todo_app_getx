import 'package:flutter/material.dart';
import 'package:todo_app_getx/constants/colors.dart';
import 'package:todo_app_getx/constants/dimensions.dart';
import 'package:todo_app_getx/constants/values.dart';

TextStyle f32TextStyle(Color color, FontWeight weight) {
  return TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: height > kSmallDeviceSizeLimit ? kFontSize32 : (kFontSize32 - 2),
    color: color,
    fontWeight: weight,
  );
}

TextStyle f28TextStyle(Color color, FontWeight weight) {
  return TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: height > kSmallDeviceSizeLimit ? kFontSize28 : (kFontSize28 - 2),
    color: color,
    fontWeight: weight,
  );
}

TextStyle f24TextStyle(Color color, FontWeight weight) {
  return TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: height > kSmallDeviceSizeLimit ? kFontSize24 : (kFontSize24 - 2),
    color: color,
    fontWeight: weight,
  );
}

TextStyle f20TextStyle(Color color, FontWeight weight) {
  return TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: height > kSmallDeviceSizeLimit ? kFontSize20 : (kFontSize20 - 2),
    color: color,
    fontWeight: weight,
  );
}

TextStyle f18TextStyle(Color color, FontWeight weight) {
  return TextStyle(
    fontFamily: 'Gilroy-Bold',
    fontSize: height > kSmallDeviceSizeLimit ? kFontSize18 : (kFontSize18 - 2),
    color: color,
    fontWeight: weight,
  );
}

TextStyle f16TextStyle(Color color, FontWeight weight) {
  return TextStyle(
    fontFamily: 'Gilroy-SemiBold',
    fontSize: height > kSmallDeviceSizeLimit ? kFontSize16 : (kFontSize16 - 2),
    color: color,
    fontWeight: weight,
  );
}

TextStyle f14TextStyle(Color color, FontWeight weight) {
  return TextStyle(
    fontFamily: 'Gilroy-Regular',
    fontSize: height > kSmallDeviceSizeLimit ? kFontSize14 : (kFontSize14 - 2),
    color: color,
    fontWeight: weight,
  );
}

TextStyle f12TextStyle(Color color, FontWeight weight) {
  return TextStyle(
    fontFamily: 'Gilroy-Regular',
    fontSize: height > kSmallDeviceSizeLimit ? kFontSize12 : (kFontSize12 - 2),
    color: color,
    fontWeight: weight,
  );
}

//* info: remove extra padding from TextButton
ButtonStyle buttonStyle(Color color) {
  return TextButton.styleFrom(
    padding: EdgeInsets.zero,
    minimumSize: Size.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    splashFactory: InkSplash.splashFactory,
  ).copyWith(overlayColor: MaterialStateProperty.all(color.withOpacity(.2)));
}

ButtonStyle? kElevatedButtonStyle = ButtonStyle(
  alignment: Alignment.center,
  // textStyle: MaterialStateProperty.all(height > kSmallDeviceSizeLimit ? sH16MediumWhite : sH14MediumWhite),
  elevation: MaterialStateProperty.all(0),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(kRadius20)),
  ),
  splashFactory: InkSplash.splashFactory,
  backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return cPlaceHolderColor;
    }
    return cBrandColor;
  }),
);

//* text field floating and error text style
TextStyle? kFloatingLabelStyle = MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
  final Color color = states.contains(MaterialState.error)
      ? cErrorColor
      : states.contains(MaterialState.focused)
          ? cBrandColor
          : cTitleTextColor;
  return TextStyle(color: color, fontSize: 12, fontFamily: 'Poppins');
});

TextStyle? kErrorInputTextStyle = const TextStyle(color: cErrorColor, fontSize: 10, fontFamily: 'Poppins');
