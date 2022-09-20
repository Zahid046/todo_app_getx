import 'package:flutter/material.dart';
import 'package:todo_app_getx/constants/colors.dart';
import 'package:todo_app_getx/constants/dimensions.dart';
import 'package:todo_app_getx/constants/styles.dart';
import 'package:todo_app_getx/constants/values.dart';
import 'package:todo_app_getx/widgets/buttons/text_button.dart';
import 'package:todo_app_getx/widgets/text_fields/text_field.dart';

class TaskDialog extends StatelessWidget {
  const TaskDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSmallPaddingUnit * 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            kH8sizedBox,
            CustomTextField(
              textEditingController: TextEditingController(),
              label: 'Name',
              cursorColor: cBrandColor,
            ),
            kH8sizedBox,
            CustomTextField(
              textEditingController: TextEditingController(),
              maxLines: 4,
              textInputAction: TextInputAction.newline,
              textInputType: TextInputType.multiline,
              cursorColor: cBrandColor,
              label: 'Description',
            ),
            kH8sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: width * .32,
                    decoration: BoxDecoration(
                      borderRadius: k5BorderRadius,
                      color: cWhiteColor,
                      border: Border.all(color: cTitleTextColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Start Date',
                            style: f14TextStyle(cPlaceHolderColor, FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: width * .32,
                    decoration: BoxDecoration(
                      borderRadius: k5BorderRadius,
                      color: cWhiteColor,
                      border: Border.all(color: cTitleTextColor),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'End Date',
                            style: f14TextStyle(cPlaceHolderColor, FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            kH8sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
            kH8sizedBox,
            CustomButton(
              buttonColor: cBrandColor,
              label: 'Save',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            kH8sizedBox,
          ],
        ),
      ),
    );
  }
}
