import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/bindings/intialbindings.dart';
import 'package:notesapp/core/app_theme.dart';
import 'package:notesapp/core/services/services.dart';
import 'package:notesapp/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialBinding: InitialBindings(),
      theme: appTheme,
      getPages: routes,
    );
  }
}
