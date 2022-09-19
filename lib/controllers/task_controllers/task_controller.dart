import 'package:get/get.dart';
import 'package:todo_app_getx/constants/urls.dart';
import 'package:todo_app_getx/constants/values.dart';
import 'package:todo_app_getx/controllers/api_controller.dart';
import 'package:todo_app_getx/helper/utility.dart';

class TaskController extends GetxController {
  final ApiController _apiController = ApiController();

  final RxBool isLoading = RxBool(false);
  final RxList taskList = RxList([]);
  final RxList totalCompleteList = RxList([]);
  final RxList totalIncompleteList = RxList([]);
  final RxMap taskDetails = RxMap({});

  @override
  void onInit() {
    getTaskList();
    super.onInit();
  }

  //create a task list fetching api call function
  Future<void> getTaskList() async {
    try {
      isLoading.value = true;

      var response = await _apiController.commonGetWithoutToken(url: kuGetAllTaskList);
      ll('message:${response['data']}');

      if (response['success'] == true) {
        taskList.value = response['data'];
        if (!Get.isSnackbarOpen) {
          successSnackBar('Success', response['message'], kSnackbarDuration);
        }
        isLoading.value = false;
      } else {
        isLoading.value = true;
        if (!Get.isSnackbarOpen) {
          errorSnackBar('Error', response['message'], kSnackbarDuration);
        }
      }
    } catch (e) {
      isLoading.value = true;
      if (!Get.isSnackbarOpen) {
        errorSnackBar('Error', 'error', kSnackbarDuration);
      }
    }
  }

  //create a task details api call function
  Future<void> getTaskDetails(String taskId) async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> body = {
        'id': taskId,
      };

      var response = await _apiController.commonPostWithoutToken(url: kuGetTaskDetails, body: body);
      ll('message:${response['data']}');

      if (response['success'] == true) {
        taskDetails.value = response['data'];
        if (!Get.isSnackbarOpen) {
          successSnackBar('Success', response['message'], kSnackbarDuration);
        }
        isLoading.value = false;
      } else {
        isLoading.value = true;
        if (!Get.isSnackbarOpen) {
          errorSnackBar('Error', response['message'], kSnackbarDuration);
        }
      }
    } catch (e) {
      isLoading.value = true;
      if (!Get.isSnackbarOpen) {
        errorSnackBar('Error', 'error', kSnackbarDuration);
      }
    }
  }

  //create a task create api call function
  Future<void> createTask() async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> body = {
        'title': 'title',
        'note': 'description',
        'start_date': '2021-09-01',
        'end_date': '2021-09-01',
        'start_time': '10:00',
        'end_time': '10:00',
      };
      var response = await _apiController.commonPostWithoutToken(url: kuCreateTask, body: body);
      ll('message:${response['data']}');

      if (response['success'] == true) {
        taskList.value = response['data'];
        if (!Get.isSnackbarOpen) {
          successSnackBar('Success', response['message'], kSnackbarDuration);
        }
        isLoading.value = false;
      } else {
        isLoading.value = true;
        if (!Get.isSnackbarOpen) {
          errorSnackBar('Error', response['message'], kSnackbarDuration);
        }
      }
    } catch (e) {
      isLoading.value = true;
      if (!Get.isSnackbarOpen) {
        errorSnackBar('Error', 'error', kSnackbarDuration);
      }
    }
  }

  // create a task deleting api call function
  Future<void> deleteTask(String taskId) async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> body = {
        'id': taskId,
      };

      var response = await _apiController.commonPostWithoutToken(url: kuDeleteTask, body: body);
      ll('message:${response['data']}');

      if (response['success'] == true) {
        taskList.value = response['data'];
        if (!Get.isSnackbarOpen) {
          successSnackBar('Success', response['message'], kSnackbarDuration);
        }
        isLoading.value = false;
      } else {
        isLoading.value = true;
        if (!Get.isSnackbarOpen) {
          errorSnackBar('Error', response['message'], kSnackbarDuration);
        }
      }
    } catch (e) {
      isLoading.value = true;
      if (!Get.isSnackbarOpen) {
        errorSnackBar('Error', 'error', kSnackbarDuration);
      }
    }
  }

  //create a task updating api call function
  Future<void> updateTask(String taskId) async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> body = {
        'id': taskId,
        'title': 'title',
        'note': 'description',
        'start_date': '2021-09-01',
        'end_date': '2021-09-01',
        'start_time': '10:00',
        'end_time': '10:00',
      };

      var response = await _apiController.commonPostWithoutToken(url: kuUpdateTask, body: body);
      ll('message:${response['data']}');

      if (response['success'] == true) {
        taskList.value = response['data'];
        if (!Get.isSnackbarOpen) {
          successSnackBar('Success', response['message'], kSnackbarDuration);
        }
        isLoading.value = false;
      } else {
        isLoading.value = true;
        if (!Get.isSnackbarOpen) {
          errorSnackBar('Error', response['message'], kSnackbarDuration);
        }
      }
    } catch (e) {
      isLoading.value = true;
      if (!Get.isSnackbarOpen) {
        errorSnackBar('Error', 'error', kSnackbarDuration);
      }
    }
  }

  //create a task complete api call function
  Future<void> completeTask(String taskId) async {
    try {
      isLoading.value = true;
      final Map<String, dynamic> body = {
        'id': taskId,
      };

      var response = await _apiController.commonPostWithoutToken(url: kuCompleteTask, body: body);
      ll('message:${response['data']}');

      if (response['success'] == true) {
        taskList.value = response['data'];
        if (!Get.isSnackbarOpen) {
          successSnackBar('Success', response['message'], kSnackbarDuration);
        }
        isLoading.value = false;
      } else {
        isLoading.value = true;
        if (!Get.isSnackbarOpen) {
          errorSnackBar('Error', response['message'], kSnackbarDuration);
        }
      }
    } catch (e) {
      isLoading.value = true;
      if (!Get.isSnackbarOpen) {
        errorSnackBar('Error', 'Unable to complete request now.', kSnackbarDuration);
      }
    }
  }
}
