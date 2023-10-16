import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddTarea extends StatefulWidget {
  const AddTarea({super.key});

  @override
  State<AddTarea> createState() => _AddTareaState();
}

class _AddTareaState extends State<AddTarea> {
  String? dropDownValue = 'No Realizada';
  TextEditingController txtConNombre = TextEditingController();
  TextEditingController txtConDsc = TextEditingController();
  TextEditingController txtConFechEx = TextEditingController();
  TextEditingController txtConFechRec = TextEditingController();
  TextEditingController txtConProfe = TextEditingController();
  List<String> dropDownValues = ["Realizada", "No Realizada"];
  @override
  Widget build(BuildContext context) {
    final txtNombre = TextFormField(
      controller: txtConNombre,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Nombre")),
    );
    final txtFechaExp = TextFormField(
      controller: txtConFechEx,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Fecha de Expiracion (dd/mm/yyyy)")),
    );
    final txtFechaRec = TextFormField(
      controller: txtConFechRec,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          label: Text("Fecha de Recordatorio (dd/mm/yyyy)")),
    );
    final txtDsc = TextField(
      maxLines: 6,
      controller: txtConDsc,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text('Description')),
    );
    final DropdownButton ddBStatus = DropdownButton(
      value: dropDownValue,
      items: dropDownValues
          .map((status) => DropdownMenuItem(value: status, child: Text(status)))
          .toList(),
      onChanged: (value) {
        dropDownValue = value;
        setState(() {});
      },
    );
    final txtProfe = TextFormField(
      controller: txtConProfe,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Profesor")),
    );
    final ElevatedButton btnGuardar =
        ElevatedButton(onPressed: () {}, child: const Text("Agregar"));
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            txtNombre,
            txtFechaExp,
            txtFechaRec,
            txtDsc,
            ddBStatus,
            txtProfe,
            btnGuardar
          ],
        ),
      ),
    );
  }
}
