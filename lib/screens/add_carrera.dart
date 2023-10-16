import 'package:app1flutter/assets/global_values.dart';
import 'package:app1flutter/database/agenda_db.dart';
import 'package:app1flutter/models/carrera_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddCarrera extends StatefulWidget {
  AddCarrera({super.key, this.carreraModel});

  CarreraModel? carreraModel;

  @override
  State<AddCarrera> createState() => _AddCarreraState();
}

class _AddCarreraState extends State<AddCarrera> {
  TextEditingController txtConCarrera = TextEditingController();
  AgendaDB? agendaDB;
  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    final txtCarrera = TextFormField(
      controller: txtConCarrera,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Carrera")),
    );
    final ElevatedButton btnGuardar = ElevatedButton(
        onPressed: () {
          if (widget.carreraModel == null) {
            agendaDB!.INSERT('tblCarrera', {
              'nomCarrera': txtConCarrera.text,
            }).then((value) {
              var msj =
                  (value > 0) ? 'La inserción fue exitosa' : 'Ocurrio un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          } else {
            GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
            agendaDB!.UPDATE_CARRERA('tblCarrera', {
              'idCarrera': widget.carreraModel!.idCarrera,
              'nomCarrera': txtConCarrera.text,
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
        child: const Text("Agregar Carrera"));
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Carrera')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [txtCarrera, btnGuardar],
        ),
      ),
    );
  }
}
