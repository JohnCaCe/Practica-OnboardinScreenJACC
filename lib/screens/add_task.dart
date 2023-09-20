import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    TextEditingController txtConName = TextEditingController();
    TextEditingController txtConDsc = TextEditingController();
    String dropDownValue = "Pendiente";
    List<String> dropDownValues = ["Pendiente", "Completado", "En Proceso"];

    final txtNameTask = TextFormField(
      controller: txtConName,
    );

    final txtDscTask = TextField(
      maxLines: 6,
      controller: txtConDsc,
    );

    final DropdownButton ddBStatus = DropdownButton(
      items: dropDownValues
          .map((status) => DropdownMenuItem(value: status, child: Text(status)))
          .toList(),
      onChanged: (value) {
        dropDownValue = value;
        setState(() {});
      },
    );

    final ElevatedButton btnGuardar =
        ElevatedButton(onPressed: () {}, child: const Text("Guardar Tarea"));

    return Scaffold(
      appBar: AppBar(
        title: const Text('AddTask'),
      ),
      body: Column(
        children: [txtNameTask, txtDscTask, ddBStatus, btnGuardar],
      ),
    );
  }
}
