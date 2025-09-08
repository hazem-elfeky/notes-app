import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notesapp/core/constant/routes.dart';
import 'package:notesapp/core/services/services.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    MyServices myServices = Get.find();

    String? step = myServices.sharedPreferences.getString("step");

    if (step == "1") {
      return const RouteSettings(name: AppRoute.noteshome);
    } else {
      return const RouteSettings(name: AppRoute.login);
    }
  }
}
