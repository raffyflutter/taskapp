import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taskapp/components/widgets.dart';
import 'package:taskapp/view_model.dart/controllers/task_controller.dart';
import 'package:taskapp/view_model.dart/servcies/respository/task_repository.dart';
import '../view_model.dart/model/task_model.dart';
import '../routes/pages.dart';
import '../utils/color_palette.dart';
import '../utils/font_sizes.dart';

class TaskItemView extends StatefulWidget {
  final TaskModel taskModel;
  final int index; // Add the index parameter

  const TaskItemView(
      {super.key,
      required this.taskModel,
      required this.index}); // Pass index as required

  @override
  State<TaskItemView> createState() => _TaskItemViewState();
}

class _TaskItemViewState extends State<TaskItemView> {
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    final TaskRepository taskRepository = TaskRepository();
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shadowColor: kBlackColor,
      color: kWhiteColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: buildText(
                          'Task ${widget.index + 1}', // Show the index number
                          kBlackColor,
                          textMedium,
                          FontWeight.bold,
                          TextAlign.start,
                          TextOverflow.clip,
                        ),
                      ),
                      PopupMenuButton<int>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: kWhiteColor,
                        elevation: 1,
                        onSelected: (value) {
                          switch (value) {
                            case 0:
                              // Edit task
                              Navigator.pushNamed(
                                context,
                                Pages.updateTask,
                                arguments: widget.taskModel,
                              );
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svgs/edit.svg',
                                    width: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  buildText(
                                    'Edit task',
                                    kBlackColor,
                                    textMedium,
                                    FontWeight.normal,
                                    TextAlign.start,
                                    TextOverflow.clip,
                                  ),
                                ],
                              ),
                            ),
                          ];
                        },
                        child: const Icon(
                          Icons.more_horiz_outlined,
                          color: kBlackColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  buildText(
                    widget.taskModel.value,
                    kBlackColor,
                    textSmall,
                    FontWeight.normal,
                    TextAlign.start,
                    TextOverflow.clip,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      taskRepository.isupdate == true
                          ? Text(
                              'Updated at: ${DateTime.now()}',
                              style:
                                  const TextStyle(fontSize: 8, color: kGrey1),
                            )
                          : Text(
                              'Created at: ${DateTime.now()}',
                              style:
                                  const TextStyle(fontSize: 8, color: kGrey1),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
