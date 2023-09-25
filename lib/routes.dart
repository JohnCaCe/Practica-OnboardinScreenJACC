//import 'package:app1flutter/card_school.dart';
import 'package:app1flutter/screens/add_task.dart';
import 'package:app1flutter/screens/dashboard_screen.dart';
import 'package:app1flutter/screens/login_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:app1flutter/screens/task_screen.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/dash': (BuildContext context) => const DashboardScreen(),
    '/task': (BuildContext context) => const TaskScreen(),
    '/add': (BuildContext context) => const AddTask(),
    '/log': (BuildContext context) => const LoginScreen(),
    //'/p1': (BuildContext context) => const CardSchoolScreen()
  };
}
