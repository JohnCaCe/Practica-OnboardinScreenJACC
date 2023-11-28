import 'package:app1flutter/assets/global_values.dart';
import 'package:app1flutter/database/agenda_db.dart';
import 'package:app1flutter/models/carrera_model.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
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
    if (widget.carreraModel != null) {
      txtConCarrera.text = widget.carreraModel!.nomCarrera!;
    }
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
            if (txtConCarrera.text == "") {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.warning,
                      title: "Accion Invalida!",
                      text:
                          "Complete los campos vacios para poder realizar la accion"));
            } else {
              agendaDB!.INSERT('tblCarrera', {
                'nomCarrera': txtConCarrera.text,
              }).then((value) {
                var msj = (value > 0)
                    ? 'La inserción fue exitosa'
                    : 'Ocurrio un error';
                var snackbar = SnackBar(content: Text(msj));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                Navigator.pop(context);
              });
            }
          } else {
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
          GlobalValues.flagCarrera.value = !GlobalValues.flagCarrera.value;
        },
        child: const Text("Guardar"));
    return Scaffold(
      appBar: AppBar(
          title: widget.carreraModel == null
              ? Text('Agregar Carrera')
              : Text('Actualizar Carrera')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [txtCarrera, btnGuardar],
        ),
      ),
    );
  }
}
