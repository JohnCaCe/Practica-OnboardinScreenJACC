import 'package:app1flutter/database/agenda_db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String dropDownValue = "Pendiente";
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConDsc = TextEditingController();
  List<String> dropDownValues = ["Pendiente", "Completado", "En Proceso"];
  AgendaDB? agendaDB;
  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    final txtNameTask = TextFormField(
      controller: txtConName,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Task")),
    );

    final txtDscTask = TextField(
      maxLines: 6,
      controller: txtConDsc,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text('Description')),
    );

    const space = SizedBox(
      height: 10,
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

    final ElevatedButton btnGuardar = ElevatedButton(
        onPressed: () {
          agendaDB!.INSERT('tblTareas', {
            'nameTask': txtConName.text,
            'descTask': txtConDsc.text,
            'stateTask': dropDownValue.substring(1, 1)
          }).then((value) {
            var msj =
                (value > 0) ? 'La inserción fue exitosa' : 'Ocurrio un error';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context);
          });
        },
        child: const Text("Guardar Tarea"));

    return Scaffold(
      appBar: AppBar(
        title: const Text('AddTask'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            txtNameTask,
            space,
            txtDscTask,
            space,
            ddBStatus,
            space,
            btnGuardar
          ],
        ),
      ),
    );
  }
}
