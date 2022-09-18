import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_getx/constants/colors.dart';
import 'package:todo_app_getx/constants/dimensions.dart';
import 'package:todo_app_getx/constants/values.dart';
import 'package:todo_app_getx/controllers/task_controllers/task_controller.dart';
import 'package:todo_app_getx/helper/utility.dart';

class AllTask extends StatelessWidget {
  AllTask({
    Key? key,
  }) : super(key: key);

  final TaskController _taskController = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    heightWidth(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height > kSmallDeviceSizeLimit ? kBigScreenAppBarHeight : kSmallScreenAppBarHeight),
        child: AppBar(
          backgroundColor: cBrandColor,
          title: const Text('All Task'),
        ),
      ),
      body: SizedBox(
        width: width,
        height: height - (height > kSmallDeviceSizeLimit ? kBigScreenAppBarHeight : kSmallScreenAppBarHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kH16sizedBox,
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => await _taskController.getTaskList(context),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Obx(
                        () => Padding(
                          padding: const EdgeInsets.only(top: kSmallPaddingUnit * 2),
                          child: _taskController.isLoading.value
                              ? const CupertinoActivityIndicator()
                              : TaskListView(
                                  taskController: _taskController,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  const TaskListView({
    Key? key,
    required TaskController taskController,
  })  : _taskController = taskController,
        super(key: key);

  final TaskController _taskController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: _taskController.isLoading.value ? 10 : _taskController.taskList.length,
        padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (listContext, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: kSmallPaddingUnit * 4),
            child: ListTile(
              onTap: () {},
              title: Text(_taskController.taskList[index]['title']),
            ),
          );
        },
      ),
    );
  }
}
