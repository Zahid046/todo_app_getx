import 'package:flutter/material.dart';
import 'package:todo_app_getx/constants/dimensions.dart';
import 'package:todo_app_getx/constants/styles.dart';
import 'package:todo_app_getx/constants/values.dart';

class CustomButton extends StatelessWidget {
  final dynamic label;
  final GestureTapCallback? onPressed;
  final double? buttonWidth, buttonHeight, iconSize;
  final Color buttonColor;
  final Color? borderColor, iconColor;
  final bool isButtonInPopUp, autoFocus, isTextButton, isSmall;
  final IconData? labelIcon;
  final TextStyle? labelTextStyle;

  const CustomButton({
    Key? key,
    this.buttonColor = Colors.amber, // todo:: this will be primary color,
    this.iconColor = Colors.grey, // todo:: this will be default icon color,
    this.borderColor,
    this.iconSize,
    required this.label,
    this.onPressed,
    this.buttonWidth,
    this.labelIcon,
    this.buttonHeight = kButtonHeight,
    this.isButtonInPopUp = true,
    this.autoFocus = false,
    this.isTextButton = false,
    this.isSmall = false,
    this.labelTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: (isTextButton || isSmall) ? const EdgeInsets.symmetric(horizontal: kPaddingSize5 * 3, vertical: kPaddingSize5 * 2) : EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: (label is IconData)
              ? const CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: isSmall ? BorderRadius.circular(100) : k10BorderRadius,
                ),
          backgroundColor: (isTextButton || label is IconData)
              ? Colors.transparent
              : (onPressed == null)
                  ? Colors.grey.withOpacity(0.2)
                  : buttonColor,
          splashFactory: InkSplash.splashFactory,
          side: BorderSide(
            color: (isTextButton || label is IconData)
                ? Colors.transparent
                : (onPressed == null)
                    ? Colors.grey.withOpacity(0.2)
                    : (borderColor ?? buttonColor),
            width: 1,
          ),
        ).copyWith(overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(.2))),
        child: Container(
          constraints: (isTextButton || isSmall)
              ? null
              : BoxConstraints(
                  maxWidth: (label is IconData) ? kButtonHeight : kButtonMaxWidth,
                  minWidth: kButtonHeight,
                ),
          height: (isTextButton || isSmall) ? null : buttonHeight,
          width: (isTextButton || isSmall) ? null : buttonWidth,
          child: Center(
            child: label is String
                ? Text(
                    label,
                    textAlign: TextAlign.center,
                    style: labelTextStyle ??
                        (isTextButton
                            ? f12TextStyle(Colors.black, FontWeight.w500)
                            : ((onPressed == null) ? f16TextStyle(Colors.grey, FontWeight.w500) : f16TextStyle(Colors.white, FontWeight.w500))),
                  )
                : label is IconData
                    ? Icon(
                        label,
                        color: iconColor,
                        size: iconSize ?? (height > kSmallDeviceSizeLimit ? kIconSize20 : kIconSize16),
                      )
                    : label,
          ),
        ),
      ),
    );
  }
}
