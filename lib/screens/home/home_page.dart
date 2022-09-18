import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_app_getx/constants/colors.dart';
import 'package:todo_app_getx/constants/values.dart';
import 'package:todo_app_getx/controllers/home_controllers/home_controller.dart';
import 'package:todo_app_getx/helper/utility.dart';
import 'package:todo_app_getx/widgets/buttons/text_button.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    heightWidth(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cBrandColor,
        title: const Text('Battery Info'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Obx(
          () => Container(
            height: height - MediaQuery.of(context).padding.top - 56,
            color: cWhiteColor,
            child: Center(
              child: _homeController.isLoading.value
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CupertinoActivityIndicator(radius: 18),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20 + 20),
                        // battery info
                        Obx(
                          () => Text('Battery Level: ${_homeController.batteryLevel.value}'),
                        ),

                        // max level
                        const SizedBox(height: 20 + 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            maxLength: 2,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Set Max Level',
                            ),
                            controller: _homeController.maxLevelController,
                            // onChanged: (value) async {
                            //   var box = await Hive.openBox('myBox');
                            //   await box.put('max', int.parse(value));
                            // },
                          ),
                        ),

                        // min level
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            controller: _homeController.minLevelController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Set Min Level',
                            ),
                            textInputAction: TextInputAction.done,
                            onSubmitted: (value) => FocusScope.of(context).unfocus(),
                            // onChanged: (value) async {
                            //   var box = await Hive.openBox('myBox');
                            //   await box.put('min', int.parse(value));
                            // },
                          ),
                        ),
                        //create a button to save the values
                        const SizedBox(height: 20),
                        CustomButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            var box = await Hive.openBox('myBox');
                            await box.put('max', int.parse(_homeController.maxLevelController.text.isEmpty ? '0' : _homeController.maxLevelController.text));
                            await box.put('min', int.parse(_homeController.minLevelController.text.isEmpty ? '0' : _homeController.minLevelController.text));
                            await box.put('is_max_notified', false);
                            await box.put('is_min_notified', false);
                          },
                          label: 'Save',
                          buttonColor: cBrandColor,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
