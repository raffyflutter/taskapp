import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:taskapp/components/widgets.dart';
import 'package:taskapp/utils/color_palette.dart';
import 'package:taskapp/utils/font_sizes.dart';
import 'package:taskapp/view_model.dart/controllers/task_controller.dart';

import '../components/build_text_field.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TaskController taskController = Get.put(TaskController());

  void handleChange(String value, {required String fieldType}) {
    if (fieldType == 'name') {
      print('Task Name changed: $value');
    } else if (fieldType == 'value') {
      print('Task Value changed: $value');
    }
  }

  @override
  void dispose() {
    super.dispose();
    taskController.valueController.value.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: kWhiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kWhiteColor,
          centerTitle: true,
          title: Text(
            'Create Task',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // buildText('Task Name', kBlackColor, textMedium, FontWeight.bold,
              //     TextAlign.start, TextOverflow.clip),
              // const SizedBox(height: 10),
              // BuildTextField(
              //   hint: 'Enter task name',
              //   controller: nameController,
              //   inputType: TextInputType.text,
              //   onChange: (value) => handleChange(value, fieldType: 'name'),
              // ),
              // const SizedBox(height: 20),
              buildText('Task Description', kBlackColor, textMedium,
                  FontWeight.bold, TextAlign.start, TextOverflow.clip),
              const SizedBox(height: 10),
              BuildTextField(
                hint: 'Enter task description',
                controller: taskController.valueController.value,
                inputType: TextInputType.multiline,
                onChange: (value) => handleChange(value, fieldType: 'value'),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: kPrimaryColor)),
                        ),
                        backgroundColor: WidgetStateProperty.all(kWhiteColor),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: buildText('Cancel', kPrimaryColor, textMedium,
                          FontWeight.w600, TextAlign.center, TextOverflow.clip),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        backgroundColor: WidgetStateProperty.all(kPrimaryColor),
                      ),
                      onPressed: () {
                        if (taskController
                            .valueController.value.text.isNotEmpty) {
                          taskController.createTask();
                          Navigator.pop(context); // Go back after creating task
                        } else {
                          Get.snackbar(
                              "Error", " Description field are required.",
                              backgroundColor: Colors.red,
                              colorText: kWhiteColor);
                        }
                      },
                      child: buildText('Save', kWhiteColor, textMedium,
                          FontWeight.w600, TextAlign.center, TextOverflow.clip),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
