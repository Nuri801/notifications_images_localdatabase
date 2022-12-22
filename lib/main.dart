import 'package:fast_campus_app/pages/image_picker_page.dart';
import 'package:fast_campus_app/pages/notification_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImagePickerPage(),
    );
  }
}



