import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:notesapp/core/constant/routes.dart';
import 'package:notesapp/core/middleware/mymiddleware.dart';
import 'package:notesapp/view/screen/auth/login.dart';
import 'package:notesapp/view/screen/auth/signup.dart';
import 'package:notesapp/view/screen/notes/noteshome.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: "/",
    page: () => const Login(),
    middlewares: [AuthMiddleware()],
  ),
  GetPage(name: AppRoute.noteshome, page: () => NotesHome()),
  GetPage(name: AppRoute.signup, page: () => const SignUp()),
  GetPage(name: AppRoute.login, page: () => const Login()),
];
