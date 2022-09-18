
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_getx/constants/dimensions.dart';
import 'package:todo_app_getx/constants/styles.dart';
import 'package:todo_app_getx/constants/values.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final String? label;
  final Widget? suffixWidget;
  final bool autoFocus, obscureText, readOnly, isSearch, enabled;
  final FocusNode? focusNode;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength, maxLines, minLines;
  final Function(String)? onChanged;
  final ValueChanged<String>? onSubmit;
  final Function()? onSuffixPress;
  final Color cursorColor;

  const CustomTextField({
    this.hint,
    this.label,
    this.onSuffixPress,
    this.autoFocus = false,
    this.enabled = true,
    this.isSearch = false,
    this.obscureText = false,
    this.readOnly = false,
    this.cursorColor = Colors.black,
    this.focusNode,
    this.maxLength = 256,
    this.maxLines = 1,
    this.minLines = 1,
    this.inputFormatters = const [],
    required this.textEditingController,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onSubmit,
    this.onChanged,
    this.suffixWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      autocorrect: false,
      obscureText: obscureText,
      textAlign: TextAlign.start,
      textCapitalization: TextCapitalization.sentences,
      style: f14TextStyle(Colors.black, FontWeight.w400),
      readOnly: readOnly,
      focusNode: focusNode,
      maxLength: maxLength,
      maxLines: maxLines,
      controller: textEditingController,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        enabled: enabled,
        filled: true,
        suffixIcon: (isSearch)
            ? IntrinsicWidth(
                child: suffixWidget,
              )
            : null,
        fillColor: isSearch ? Colors.transparent : Colors.grey.withOpacity(.2),
        alignLabelWithHint: true, // This is necessary if the maxLines is greater than line 1.
        hintText: hint,
        labelText: label,
        hintStyle: f14TextStyle(Colors.grey, FontWeight.w400),
        counter: const SizedBox.shrink(),
        contentPadding: const EdgeInsets.symmetric(horizontal: kPaddingSize20, vertical: kPaddingSize10),
        floatingLabelBehavior: label == null ? FloatingLabelBehavior.never : FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: k10BorderRadius,
          borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
        enabledBorder: isSearch
            ? OutlineInputBorder(
                borderRadius: k10BorderRadius,
                borderSide: BorderSide(width: 1, color: cursorColor.withOpacity(.2)),
              )
            : null,
        focusedBorder: isSearch
            ? OutlineInputBorder(
                borderRadius: k10BorderRadius,
                borderSide: BorderSide(width: 1, color: cursorColor.withOpacity(.2)),
              )
            : null,
      ),
      keyboardType: textInputType,
      textInputAction: textInputAction,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
    );
  }
}
