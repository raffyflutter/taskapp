import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:taskapp/utils/font_sizes.dart';
import 'package:taskapp/view_model.dart/controllers/task_controller.dart';
import '../components/custom_app_bar.dart';
import '../components/widgets.dart';
import '../view_model.dart/model/task_model.dart';
import '../utils/color_palette.dart';
import '../components/build_text_field.dart';

class UpdateTaskScreen extends StatefulWidget {
  final TaskModel taskModel;

  const UpdateTaskScreen({super.key, required this.taskModel});

  @override
  State<UpdateTaskScreen> createState() => _UpdateTaskScreenState();
}

class _UpdateTaskScreenState extends State<UpdateTaskScreen> {
  String? taskId;

  final TaskController taskController = Get.put(TaskController());

  @override
  void initState() {
    taskId = widget.taskModel.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

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
                'Update Task',
              ),
            ),
            body: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: [
                      const SizedBox(height: 20),
                      const SizedBox(
                        height: 20,
                      ),
                      buildText('Task Description', kBlackColor, textMedium,
                          FontWeight.bold, TextAlign.start, TextOverflow.clip),
                      const SizedBox(
                        height: 10,
                      ),
                      BuildTextField(
                          hint: "Update Description",
                          controller: taskController.valueController.value,
                          inputType: TextInputType.multiline,
                          fillColor: kWhiteColor,
                          onChange: (value) {}),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 22),
                      SizedBox(
                        width: size.width,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  WidgetStateProperty.all<Color>(Colors.white),
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(kPrimaryColor),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (taskController
                                  .valueController.value.text.isNotEmpty) {
                                print('UpdatedTaskId: $taskId');
                                print(
                                    'UpdatedTaskStatus: ${widget.taskModel.status}');

                                taskController.updateTaskApi(
                                    taskId.toString(),
                                    taskController.valueController.value.text,
                                    widget.taskModel.status.toString());

                                Navigator.pop(context);
                              } else {
                                Get.snackbar(
                                    "Error", "Description fields are required.",
                                    backgroundColor: Colors.red,
                                    colorText: kWhiteColor);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: buildText(
                                  'Update',
                                  kWhiteColor,
                                  textMedium,
                                  FontWeight.w600,
                                  TextAlign.center,
                                  TextOverflow.clip),
                            )),
                      ),
                    ],
                  ),
                ))));
  }
}
