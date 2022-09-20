import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo_app_getx/constants/colors.dart';
import 'package:todo_app_getx/constants/dimensions.dart';
import 'package:todo_app_getx/constants/styles.dart';
import 'package:todo_app_getx/constants/values.dart';
import 'package:todo_app_getx/controllers/task_controllers/task_controller.dart';
import 'package:todo_app_getx/helper/date_converter.dart';
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight),
        child: FloatingActionButton(
          backgroundColor: cBrandColor,
          onPressed: () {},
          child: const Icon(
            Icons.add,
            color: cWhiteColor,
          ),
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height > kSmallDeviceSizeLimit ? kBigScreenAppBarHeight : kSmallScreenAppBarHeight),
        child: AppBar(
          backgroundColor: cBrandColor,
          title: const Text('All Task'),
        ),
      ),
      body: SizedBox(
        width: width,
        height: height - (height > kSmallDeviceSizeLimit ? kBigScreenAppBarHeight : kSmallScreenAppBarHeight) - MediaQuery.of(context).padding.top,
        child: RefreshIndicator(
          color: cBrandColor,
          onRefresh: () async => await _taskController.getTaskList(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: kSmallPaddingUnit * 2),
                      child: TaskListView(
                        taskController: _taskController,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
        padding: const EdgeInsets.symmetric(horizontal: kSmallPaddingUnit * 4),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (listContext, index) {
          return _taskController.isLoading.value
              ? const ShimmerListTile()
              : Padding(
                  padding: const EdgeInsets.only(bottom: kSmallPaddingUnit * 2),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: k5BorderRadius, color: cBodyColor.withOpacity(.1)),
                    child: ClipRRect(
                      borderRadius: k5BorderRadius,
                      child: Slidable(
                        endActionPane: ActionPane(
                          extentRatio: .5,
                          motion: const ScrollMotion(),
                          children: _swipeRight(index, context),
                        ),
                        startActionPane: ActionPane(
                          extentRatio: .5,
                          motion: const ScrollMotion(),
                          children: _swipeLeft(index),
                        ),
                        child: ListTile(
                          dense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: kSmallPaddingUnit * 3),
                          onTap: () {},
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  _taskController.taskList[index]['title'],
                                  style: f16TextStyle(cTitleTextColor, FontWeight.w500).copyWith(
                                    decoration: _taskController.taskList[index]['is_completed'] == 0 ? null : TextDecoration.lineThrough,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "${DateConverter.convertTimeToTime(_taskController.taskList[index]['start_time'])} - ${DateConverter.convertTimeToTime(
                                  _taskController.taskList[index]['end_time'],
                                )}",
                                style: f14TextStyle(cTitleTextColor, FontWeight.w500).copyWith(
                                  decoration: _taskController.taskList[index]['is_completed'] == 0 ? null : TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  _taskController.taskList[index]['note'] ?? '',
                                  style: f14TextStyle(cTitleTextColor, FontWeight.w400).copyWith(
                                    decoration: _taskController.taskList[index]['is_completed'] == 0 ? null : TextDecoration.lineThrough,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                "${DateConverter.dateStringToDate(_taskController.taskList[index]['start_date'])} - ${DateConverter.dateStringToDate(
                                  _taskController.taskList[index]['end_date'],
                                )}",
                                style: f14TextStyle(cTitleTextColor, FontWeight.w400).copyWith(
                                  decoration: _taskController.taskList[index]['is_completed'] == 0 ? null : TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  List<Widget> _swipeRight(index, context) {
    return [
      SlidableAction(
        onPressed: (listContext) async {
          // await _taskController.updateTask(_taskController.taskList[index]['id'].toString());
          await _taskController.showEditDialog(context);
        },
        backgroundColor: cBrandColor,
        foregroundColor: cWhiteColor,
        icon: Icons.edit,
        label: 'Edit',
      ),
      SlidableAction(
        onPressed: (listContext) async {
          await _taskController.deleteTask(_taskController.taskList[index]['id'].toString());
        },
        backgroundColor: cErrorColor,
        foregroundColor: cWhiteColor,
        icon: Icons.delete,
        label: 'Delete',
      ),
    ];
  }

  List<Widget> _swipeLeft(index) {
    return [
      SlidableAction(
        onPressed: (listContext) async {
          await _taskController.completeTask(_taskController.taskList[index]['id'].toString());
        },
        backgroundColor: _taskController.taskList[index]['is_completed'] == 0 ? cSuccessColor : cPendingColor,
        foregroundColor: cWhiteColor,
        icon: _taskController.taskList[index]['is_completed'] == 0 ? Icons.done : Icons.close,
        label: _taskController.taskList[index]['is_completed'] == 0 ? 'Complete' : 'Incomplete',
      ),
    ];
  }
}

class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: cWhiteColor,
      highlightColor: Colors.grey[600]!,
      child: Padding(
        padding: const EdgeInsets.only(bottom: kSmallPaddingUnit * 2),
        child: Container(
          decoration: BoxDecoration(borderRadius: k5BorderRadius, color: cBodyColor.withOpacity(.1)),
          child: ClipRRect(
            borderRadius: k5BorderRadius,
            child: ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: kSmallPaddingUnit * 3),
              onTap: () {},
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Expanded(
                    child: Text(
                      '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '',
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Expanded(
                    child: Text(
                      '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
