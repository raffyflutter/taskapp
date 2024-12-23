import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:taskapp/components/custom_app_bar.dart';
import 'package:taskapp/data/local_storage_services/local_storage_methods_services.dart';
import 'package:taskapp/routes/pages.dart';
import 'package:taskapp/utils/color_palette.dart';
import 'package:taskapp/view/task_item_view.dart';
import 'package:taskapp/view_model.dart/controllers/auth_con.dart';
import 'package:taskapp/view_model.dart/controllers/task_controller.dart';
import '../components/widgets.dart';
import '../utils/font_sizes.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final AuthController authController = Get.put(AuthController());
  final TaskController taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    taskController.fetchData();
  }

  // ignore: unused_field
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushNamed(context, Pages.home);
    } else if (index == 1) {
      Navigator.pushNamed(context, Pages.createNewTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: kSecondaryColor,
        appBar: CustomAppBar(
          actionWidgets: [
            IconButton(
              splashColor: Colors.transparent,
              onPressed: () {},
              icon: const Icon(
                Icons.task,
                size: 35,
                color: kBlackColor,
              ),
            ),
            const SizedBox(width: 10),
          ],
          title: 'Hello!,\n${LocalStorageMethods.instance.getUsername()}',
          showBackArrow: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 12),
                height: MediaQuery.of(context).size.height / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PopupMenuButton<String>(
                            surfaceTintColor: kWhiteColor,
                            padding: EdgeInsets.zero,
                            menuPadding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            onSelected: (value) {
                              authController.logout();
                            },
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem<String>(
                                value: 'logout',
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Username on the left
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Here is your\ndaily task 😊',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // "View your task" text on the right
                          Container(
                            width: 80,
                            height: 30,
                            margin: EdgeInsets.only(right: 10, top: 20),
                            decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Text(
                                'View Tasks',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                '  Task Group',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Obx(() => taskController.tasks.isEmpty
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height * 0.08),
                          SvgPicture.asset(
                            'assets/svgs/tasks.svg',
                            height: size.height * .20,
                            width: size.width,
                          ),
                          const SizedBox(height: 50),
                          buildText(
                            'Schedule your tasks',
                            kBlackColor,
                            textBold,
                            FontWeight.w600,
                            TextAlign.center,
                            TextOverflow.clip,
                          ),
                          buildText(
                            'Manage your task schedule easily\nand efficiently',
                            kBlackColor.withOpacity(.5),
                            textSmall,
                            FontWeight.normal,
                            TextAlign.center,
                            TextOverflow.clip,
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: taskController.tasks.length,
                        itemBuilder: (context, index) {
                          return TaskItemView(
                            taskModel: taskController.tasks[index],
                            index: index,
                          );
                        },
                      ),
                    )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: kPrimaryColor,
          child: const Icon(
            Icons.add,
            color: kWhiteColor,
          ),
          onPressed: () {
            Navigator.pushNamed(context, Pages.createNewTask);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: BottomAppBar(
            color: kPrimaryColor,
            shape: const CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.home,
                    color: kWhiteColor,
                  ),
                  onPressed: () {
                    _onItemTapped(0); // Navigate to Home Page
                  },
                ),
                SizedBox(
                  width: 50,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.list_alt,
                    color: kWhiteColor,
                  ),
                  onPressed: () {
                    _onItemTapped(1); // Navigate to Task Page
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
