//import 'package:app1flutter/card_school.dart';
import 'package:app1flutter/screens/add_carrera.dart';
import 'package:app1flutter/screens/add_profesor.dart';
import 'package:app1flutter/screens/add_tarea.dart';
import 'package:app1flutter/screens/add_task.dart';
import 'package:app1flutter/screens/calendar_screen.dart';
import 'package:app1flutter/screens/carrera_screen.dart';
import 'package:app1flutter/screens/dashboard_screen.dart';
import 'package:app1flutter/screens/detail_movie_screen.dart';
import 'package:app1flutter/screens/login_screen.dart';
import 'package:app1flutter/screens/popular_screen.dart';
import 'package:app1flutter/screens/profesor_screen.dart';
import 'package:app1flutter/screens/provider_screen.dart';
import 'package:app1flutter/screens/register_screen.dart';
import 'package:app1flutter/screens/tareas_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:app1flutter/screens/task_screen.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/dash': (BuildContext context) => const DashboardScreen(),
    '/task': (BuildContext context) => const TaskScreen(),
    '/add': (BuildContext context) => AddTask(),
    '/log': (BuildContext context) => const LoginScreen(),
    //'/p1': (BuildContext context) => const CardSchoolScreen()

    '/popular': (BuildContext context) => const PopularScreen(),
    '/detail': (BuildContext context) => const DetailMovieScreen(),
    '/prov': (BuildContext context) => const ProviderScreen(),
    '/carr': (BuildContext context) => const CarreraScreen(),
    '/profe': (BuildContext context) => const ProfesorScreen(),
    '/tarea': (BuildContext context) => const TareasScreen(),
    '/AddCarr': (BuildContext context) => AddCarrera(),
    '/AddProfe': (BuildContext context) => AddProfesor(),
    '/AddTar': (BuildContext context) => AddTarea(),
    '/calen': (BuildContext context) => const CalendarScreen(),
    '/register': (BuildContext context) => const RegisterScreen(),
  };
}
