import 'package:app1flutter/assets/global_values.dart';
import 'package:app1flutter/database/agenda_db.dart';
import 'package:app1flutter/models/task_model.dart';
import 'package:app1flutter/models/tasks_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key, this.taskModel});

  TaskModel? taskModel;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String? dropDownValue = 'Pendiente';
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConDsc = TextEditingController();
  List<String> dropDownValues = ["Pendiente", "Completado", "En Proceso"];
  AgendaDB? agendaDB;
  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    if (widget.taskModel != null) {
      txtConName.text = widget.taskModel!.nameTask!;
      txtConDsc.text = widget.taskModel!.descTask!;
      switch (widget.taskModel!.stateTask) {
        case 'E':
          dropDownValue = 'En Proceso';
          break;
        case 'C':
          dropDownValue = 'Completado';
          break;
        case 'P':
          dropDownValue = 'Pendiente';
          break;
      }
    }
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
          if (widget.taskModel == null) {
            agendaDB!.INSERT('tblTareas', {
              'nameTask': txtConName.text,
              'descTask': txtConDsc.text,
              'stateTask': dropDownValue!.substring(0, 1)
            }).then((value) {
              var msj =
                  (value > 0) ? 'La inserción fue exitosa' : 'Ocurrio un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          } else {
            GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
            agendaDB!.UPDATE('tblTareas', {
              'idTask': widget.taskModel!.idTask,
              'nameTask': txtConName.text,
              'descTask': txtConDsc.text,
              'stateTask': dropDownValue!.substring(0, 1)
            }).then((value) {
              var msj = (value > 0)
                  ? 'La actualización fue exitosa'
                  : 'Ocurrio un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          }
        },
        child: const Text("Guardar Tarea"));

    return Scaffold(
      appBar: AppBar(
          title: widget.taskModel == null
              ? Text('Add Task')
              : Text('Update Task')),
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
