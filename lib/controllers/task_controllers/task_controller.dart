import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/constants/colors.dart';
import 'package:todo_app_getx/constants/urls.dart';
import 'package:todo_app_getx/constants/values.dart';
import 'package:todo_app_getx/controllers/api_controller.dart';
import 'package:todo_app_getx/helper/utility.dart';

class TaskController extends GetxController {
  final ApiController _apiController = ApiController();

  final RxBool isLoading = RxBool(false);
  final RxList taskList = RxList([]);

  //create a task list fetching api call function
  Future<void> getTaskList(BuildContext context) async {
    try {
      isLoading.value = true;

      var response = await _apiController.commonGetWithoutToken(url: kuGetAllTaskList, context: context);
      ll('message:$response');

      if (response['success'] == true) {
        taskList.value = response['data'];
        isLoading.value = false;
        // showToast(context, Icons.check, 'Success', response['message'], cSuccessColor);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(getSnackBar(context, width, 'Success', response['message'], cSuccessColor));
      } else {
        isLoading.value = true;
        // showToast(context, Icons.check, 'Error', response['message'], cErrorColor);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(getSnackBar(context, width, 'Error', response['message'], cErrorColor));
      }
    } catch (e) {
      isLoading.value = true;
      // showToast(context, Icons.check, 'Error', 'Unable to get data', cErrorColor);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(getSnackBar(context, width, 'Error', 'Unable to get data', cErrorColor));
    }
  }
}
