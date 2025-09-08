import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/core/app_theme.dart' as AppColor;

Future<bool> alertExitApp() {
  Get.defaultDialog(
    title: "تنبيه",
    titleStyle: TextStyle(
      color: AppColor.primaryColor,
      fontWeight: FontWeight.bold,
    ),
    middleText: "هل تريد الخروج من التطبيق",
    actions: [
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColor.primaryColor),
        ),
        onPressed: () {
          exit(0);
        },
        child: const Text("تاكيد"),
      ),
      ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColor.primaryColor),
        ),
        onPressed: () {
          Get.back();
        },
        child: const Text("الغاء"),
      ),
    ],
  );
  return Future.value(true);
}
