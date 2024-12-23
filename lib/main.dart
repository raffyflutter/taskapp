import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskapp/utils/color_palette.dart';

import 'data/local_storage_services/shared_preferences.dart';
import 'routes/app_router.dart';
import 'routes/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      initialRoute: Pages.initial,
      onGenerateRoute: onGenerateRoute,
      theme: ThemeData(
        fontFamily: 'Sora',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.transparent,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
        useMaterial3: true,
      ),
    );
  }
}
