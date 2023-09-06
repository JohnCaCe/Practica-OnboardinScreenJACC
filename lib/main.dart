import 'package:app1flutter/assets/styles_app.dart';
import 'package:app1flutter/card_school.dart';
import 'package:app1flutter/routes.dart';
import 'package:app1flutter/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      //home: const LoginScreen(),
      routes: getRoutes(),
      theme: StylesApp.darkTheme(context),
    );
  }
}

class Home extends StatelessWidget {
  Home({super.key});

  final data = [
    CardSchoolData(
        title: "TECNM en Celaya",
        subtitle:
            "El Tecnológico Nacional de México en Celaya fue fundado en 1958 como un centro de segunda enseñanza, capacitación técnica para trabajadores y preparatoria técnica especializada; actualmente es una de las Instituciones de Educación Superior mejor posicionadas a nivel nacional e Internacional.",
        image: const AssetImage("assets/tecnoimg.png"),
        backgroundColor: const Color.fromARGB(255, 93, 164, 16),
        titleColor: Colors.pink,
        subtitleColor: Colors.white,
        background: LottieBuilder.asset("assets/animations/animation1v2.json")),
    CardSchoolData(
        title: "Sistemas Computacionales",
        subtitle:
            "El y la Ingeniero/a en Sistemas Computacionales, tiene conocimientos de alto nivel tecnológico y científico para ser un profesionista con visión innovadora capaz de crear y proveer soluciones de software e infraestructura computacional de vanguardia en la nueva y dinámica sociedad dela era digital.",
        image: const AssetImage("assets/carrera.jpg"),
        backgroundColor: const Color.fromARGB(255, 8, 98, 224),
        titleColor: const Color.fromARGB(255, 52, 206, 237),
        subtitleColor: Color.fromARGB(255, 106, 255, 32),
        background: LottieBuilder.asset("assets/animations/animation2.json")),
    CardSchoolData(
        title: "Instalaciones",
        subtitle:
            "Las instalaciones para la carrera de Ingenieria en Sistemas Computacionales se encuentran hubicadas en el Campus 2, las cuales son el edificio C y el edificio UTICS",
        image: const AssetImage("assets/instalaciones.png"),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        titleColor: const Color.fromARGB(255, 109, 212, 18),
        subtitleColor: const Color.fromARGB(255, 0, 0, 0),
        background: LottieBuilder.asset("assets/animations/animation4.json"))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return CardSchool(data: data[index]);
        },
      ),
    );
    ;
  }
}
