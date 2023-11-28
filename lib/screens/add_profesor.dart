import 'package:app1flutter/assets/global_values.dart';
import 'package:app1flutter/database/agenda_db.dart';
import 'package:app1flutter/models/carrera_model.dart';
import 'package:app1flutter/models/profesor_model.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddProfesor extends StatefulWidget {
  AddProfesor({super.key, this.profesorModel});

  ProfesorModel? profesorModel;

  @override
  State<AddProfesor> createState() => _AddProfesorState();
}

class _AddProfesorState extends State<AddProfesor> {
  TextEditingController txtConNombre = TextEditingController();
  CarreraModel? dropDownValue;
  List<CarreraModel>? dropDownValues;
  var idCarrera;
  TextEditingController txtConEmail = TextEditingController();
  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    if (widget.profesorModel != null) {
      txtConNombre.text = widget.profesorModel!.nomProfe!;
      txtConEmail.text = widget.profesorModel!.email!;
      getCarrera();
    } else {
      getCarreras();
    }
  }

  Future getCarrera() async {
    final carrera =
        await agendaDB!.GETNOMCARRBYID(widget.profesorModel!.idCarrera!);
    final carreras = await agendaDB!.GETALLCARRERAS();
    setState(() {
      dropDownValues = carreras;
      for (int i = 0; i < carreras.length; i++) {
        if (carreras[i].idCarrera == carrera.idCarrera) {
          dropDownValue = carreras[i];
          break;
        }
      }
    });
  }

  Future getCarreras() async {
    final carreras = await agendaDB!.GETALLCARRERAS();
    setState(() {
      dropDownValues = carreras;
      dropDownValue = carreras[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final txtNombre = TextFormField(
      controller: txtConNombre,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Nombre")),
    );
    final DropdownButton carrera = DropdownButton(
        value: dropDownValue,
        items: dropDownValues
            ?.map((carrera) => DropdownMenuItem(
                value: carrera, child: Text(carrera.nomCarrera!)))
            .toList(),
        onChanged: (value) {
          dropDownValue = value;
          setState(() {});
        });
    final txtEmail = TextFormField(
      controller: txtConEmail,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Email")),
    );
    final btnGuardar = ElevatedButton(
        onPressed: () {
          if (widget.profesorModel == null) {
            if (txtConNombre.text == "" || txtConEmail.text == "") {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.warning,
                      title: "Accion Invalida!",
                      text:
                          "Complete los campos vacios para poder realizar la accion"));
            } else {
              agendaDB!.INSERT('tblProfesor', {
                'nomProfe': txtConNombre.text,
                'idCarrera': dropDownValue!.idCarrera,
                'email': txtConEmail.text
              }).then((value) {
                var msj = (value > 0)
                    ? "La insercción fue exitosa"
                    : "Ocurrio un error";
                var snackbar = SnackBar(content: Text(msj));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                Navigator.pop(context);
              });
            }
          } else {
            agendaDB!.GETIDCARRERA(dropDownValue! as String).then((list) {
              list.map((e) {
                idCarrera = int.parse(e['idCarrera'].toString());
              }).forEach((element) {
                setState(() {});
              });
            }).whenComplete(() => agendaDB!.UPDATE_PROFE('tblProfesor', {
                  'idProfe': widget.profesorModel!.idProfe,
                  'nomProfe': txtConNombre.text,
                  'idCarrera': idCarrera,
                  'email': txtConEmail.text
                }).then((value) {
                  var msj = (value > 0)
                      ? "La actualización fue exitosa"
                      : "Ocurrio un error";
                  var snackbar = SnackBar(content: Text(msj));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  Navigator.pop(context);
                }));
          }
          GlobalValues.flagProfesor.value = !GlobalValues.flagProfesor.value;
        },
        child: const Text("Agregar Profesor"));
    return Scaffold(
      appBar: AppBar(
          title: widget.profesorModel == null
              ? Text('Agregar Profesor')
              : Text('Actualizar Profesor')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [txtNombre, carrera, txtEmail, btnGuardar],
        ),
      ),
    );
  }
}
