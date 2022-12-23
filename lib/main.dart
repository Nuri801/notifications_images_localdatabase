import 'package:fast_campus_app/pages/image_picker_page.dart';
import 'package:fast_campus_app/pages/notification_page.dart';
import 'package:fast_campus_app/pages/user_list_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/inputform.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  runApp(const MyApp());
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(InputFormAdapter());
  await Hive.openBox("darkModeBox");
  await Hive.openBox<InputForm>("inputFormBox");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: Hive.box("darkModeBox").listenable(),

        builder: (context, box, widget) {
          final darkMode = box.get('darkMode', defaultValue: false);
          return MaterialApp(
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: UserListPage(),
        );
      },
    );
  }
}



