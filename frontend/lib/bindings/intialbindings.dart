import 'package:get/get.dart';
import 'package:notesapp/core/class/crud.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
  }
}
