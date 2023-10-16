import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddProfesor extends StatefulWidget {
  const AddProfesor({super.key});

  @override
  State<AddProfesor> createState() => _AddProfesorState();
}

class _AddProfesorState extends State<AddProfesor> {
  TextEditingController txtConNombre = TextEditingController();
  TextEditingController txtConCarrera = TextEditingController();
  TextEditingController txtConEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final txtNombre = TextFormField(
      controller: txtConNombre,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Nombre")),
    );
    final txtCarrera = TextFormField(
      controller: txtConCarrera,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Carrera")),
    );
    final txtEmail = TextFormField(
      controller: txtConEmail,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Email")),
    );
    final ElevatedButton btnGuardar =
        ElevatedButton(onPressed: () {}, child: const Text("Agregar"));
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Profesor')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [txtNombre, txtCarrera, txtEmail, btnGuardar],
        ),
      ),
    );
  }
}
