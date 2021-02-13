import 'package:businesslisting/screens/add_business.dart';
import 'package:businesslisting/screens/dash_screen.dart';
import 'package:businesslisting/screens/login_screen.dart';
import 'package:businesslisting/screens/register_screen.dart';
import 'package:get/get.dart';

class RoutesPath {
  static final route = [
    GetPage(
      name: '/registerView',
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: '/loginView',
      page: () => LoginScreen(),
    ),
    GetPage(
      name: '/dashView',
      page: () => DashScreen(),
    ),
    GetPage(
      name: '/addBusinessView',
      page: () => AddBusinessScreen(),
      transition: Transition.size,
    ),
  ];
}
