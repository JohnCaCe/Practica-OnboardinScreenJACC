import 'dart:async';
import 'package:app1flutter/assets/global_values.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isChecked = true;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  initState() {
    checkSession().whenComplete(() async {
      print(" checked : $isChecked");
      Timer(Duration(seconds: 3),
          () => isChecked == true ? isChecked = true : isChecked = false);
    });
    super.initState();
  }

  saveSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("session", false);
  }

  Future checkSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtenerSesion = prefs.getBool("session");
    setState(() {
      if (obtenerSesion != true) {
        isChecked = false;
      } else {
        isChecked = true;
      }
    });
  }

  guardarTema() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("theme", GlobalValues.flagTheme.value);
  }

  Future checkTema() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("theme") != null && prefs.getBool("theme") != false) {
      GlobalValues.flagTheme.value = true;
    } else {
      GlobalValues.flagTheme.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenidos Todos UwU'),
      ),
      drawer: createDrawer(context),
    );
  }

  Widget createDrawer(context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/originals/21/06/da/2106dabd9a7d0a071ef737e419feb077.jpg'),
              ),
              accountName: Text('Jonathan Camacho'),
              accountEmail: Text('19030809@itcelaya.edu.mx')),
          ListTile(
            leading: Image.network(
                'https://www.pngmart.com/files/2/Scarlet-Witch-PNG-HD.png'),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('BellakaApp'),
            subtitle: const Text('Carrousel'),
            onTap: () => Navigator.pushNamed(context, '/popular'),
          ),
          /*ListTile(
            leading: const Icon(Icons.task_alt_outlined),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Task Manager'),
            onTap: () => Navigator.pushNamed(context, '/task'),
          ),*/
          ListTile(
            leading: const Icon(Icons.message),
            trailing: const Icon(Icons.chevron_right),
            iconColor: Color.fromARGB(255, 175, 246, 43),
            title: const Text('Test Provider'),
            onTap: () => Navigator.pushNamed(context, '/prov'),
          ),
          ListTile(
            leading: const Icon(Icons.radar),
            trailing: const Icon(Icons.chevron_right),
            iconColor: Color.fromARGB(255, 251, 179, 9),
            title: const Text('Carreras'),
            onTap: () => Navigator.pushNamed(context, '/carr'),
          ),
          ListTile(
            leading: const Icon(Icons.school_rounded),
            trailing: const Icon(Icons.chevron_right),
            iconColor: Color.fromARGB(255, 79, 66, 17),
            title: const Text('Profesores'),
            onTap: () => Navigator.pushNamed(context, '/profe'),
          ),
          ListTile(
            leading: const Icon(Icons.task_alt),
            trailing: const Icon(Icons.chevron_right),
            iconColor: Color.fromARGB(255, 60, 196, 255),
            title: const Text('Tareas'),
            onTap: () => Navigator.pushNamed(context, '/tarea'),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_view_day),
            trailing: const Icon(Icons.chevron_right),
            iconColor: Color.fromARGB(255, 255, 255, 255),
            title: const Text('Calendario'),
            onTap: () => Navigator.pushNamed(context, '/calen'),
          ),
          DayNightSwitcher(
            isDarkModeEnabled: GlobalValues.flagTheme.value,
            onStateChanged: (isDarkModeEnabled) {
              GlobalValues.flagTheme.value = isDarkModeEnabled;
              guardarTema();
            },
          ),
          const SizedBox(
            height: 100,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            trailing: const Icon(Icons.chevron_right),
            iconColor: const Color.fromARGB(255, 255, 16, 16),
            title: const Text('Cerrar Sesión'),
            onTap: () => Navigator.pushNamed(context, '/log'),
          ),
        ],
      ),
    );
  }
}
