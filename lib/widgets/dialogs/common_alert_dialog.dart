import 'package:flutter/material.dart';
import 'package:todo_app_getx/constants/colors.dart';
import 'package:todo_app_getx/constants/dimensions.dart';
import 'package:todo_app_getx/constants/styles.dart';
import 'package:todo_app_getx/constants/values.dart';
import 'package:todo_app_getx/widgets/buttons/text_button.dart';

class CommonAlertDialog extends StatelessWidget {
  const CommonAlertDialog({
    this.title,
    required this.addContent,
    this.hasCloseBtn = false,
    this.actions,
    this.onClose,
    Key? key,
  }) : super(key: key);

  final String? title;
  final Widget? addContent;
  final bool hasCloseBtn;
  final List<Widget>? actions;
  final Function()? onClose;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius5),
      ),
      elevation: 0,
      titlePadding: EdgeInsets.zero,
      title: SizedBox(
        height: 40,
        width: width,
        child: Stack(
          children: [
            if (title != null)
              Center(
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: f16TextStyle(cTitleTextColor, FontWeight.w500),
                ),
              ),
            if (hasCloseBtn)
              Positioned(
                right: 0,
                top: 0,
                child: CustomButton(
                  onPressed: onClose,
                  label: Icons.close,
                  iconSize: height > kSmallDeviceSizeLimit ? kIconSize20 : kIconSize16,
                ),
              ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.all(0),
      content: addContent,
      actionsPadding: const EdgeInsets.only(bottom: kPaddingSize0),
      actions: actions,
    );
  }
}
