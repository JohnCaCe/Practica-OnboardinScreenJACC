import 'package:app1flutter/assets/global_values.dart';
import 'package:app1flutter/database/agenda_db.dart';
import 'package:app1flutter/models/profesor_model.dart';
import 'package:app1flutter/models/task_model.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class AddTarea extends StatefulWidget {
  AddTarea({super.key, this.tareaModel});

  TareaModel? tareaModel;

  @override
  State<AddTarea> createState() => _AddTareaState();
}

class _AddTareaState extends State<AddTarea> {
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConDsc = TextEditingController();
  TextEditingController txtConExpDate = TextEditingController();
  String? recordar;
  ProfesorModel? dropDownValue;
  List<ProfesorModel>? dropDownValues;
  DateTime? pickedDate;
  AgendaDB? agendaDB;

  String? dropValueState = "NO REALIZADA";
  List<String>? dropStateValues = ["NO REALIZADA", "REALIZADA"];

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    if (widget.tareaModel != null) {
      txtConName.text = widget.tareaModel!.nomTarea!;
      txtConDsc.text = widget.tareaModel!.desTarea!;
      txtConExpDate.text = widget.tareaModel!.fechaExpiracion!;
      recordar = widget.tareaModel!.fechaExpiracion;
      dropValueState =
          widget.tareaModel!.realizada! == 0 ? "NO REALIZADA" : "REALIZADA";
      getProfesor();
    } else {
      getProfesores();
    }
  }

  Future getProfesor() async {
    final profesor =
        await agendaDB!.GETNOMPROFEBYID(widget.tareaModel!.idProfe!);
    final profesores = await agendaDB!.GETALLPROFESOR();
    setState(() {
      dropDownValues = profesores;
      for (int i = 0; i < profesores.length; i++) {
        if (profesores[i].idProfe == profesor.idProfe) {
          dropDownValue = profesores[i];
          break;
        }
      }
    });
  }

  Future getProfesores() async {
    final profesores = await agendaDB!.GETALLPROFESOR();
    setState(() {
      dropDownValues = profesores;
      dropDownValue = profesores[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateInput = TextField(
        controller: txtConExpDate,
        decoration: const InputDecoration(
            icon: Icon(Icons.calendar_today), labelText: "Fecha de Expiración"),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(), //get today's date
              firstDate: DateTime(
                  2000), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            setState(() {
              txtConExpDate.text = formattedDate;
              recordar = DateFormat('yyyy-MM-dd')
                  .format(pickedDate.subtract(const Duration(days: 1)));
            });
          } else {
            print("No se ha seleccionado una fecha");
          }
        });
    final txtNameTarea = TextFormField(
      controller: txtConName,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Tarea")),
    );

    final txtDscTarea = TextField(
      maxLines: 6,
      controller: txtConDsc,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text('Description')),
    );

    const space = SizedBox(
      height: 10,
    );

    final DropdownButton ddBProfe = DropdownButton(
      value: dropDownValue,
      items: dropDownValues
          ?.map((profesor) => DropdownMenuItem(
              value: profesor, child: Text(profesor.nomProfe!)))
          .toList(),
      onChanged: (value) {
        dropDownValue = value;
        setState(() {});
      },
    );

    final DropdownButton ddbStatus = DropdownButton(
        value: dropValueState,
        items: dropStateValues
            ?.map((status) =>
                DropdownMenuItem(value: status, child: Text(status)))
            .toList(),
        onChanged: (value) {
          dropValueState = value;
          setState(() {});
        });

    final ElevatedButton btnGuardar = ElevatedButton(
        onPressed: () {
          if (widget.tareaModel == null) {
            if (txtConName.text == "" ||
                txtConDsc.text == "" ||
                txtConExpDate.text == "") {
              ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                      type: ArtSweetAlertType.warning,
                      title: "Accion Invalida!",
                      text:
                          "Complete los campos vacios para poder realizar la accion"));
            } else {
              agendaDB!.INSERT('tblTarea', {
                'nomTarea': txtConName.text,
                'desTarea': txtConDsc.text,
                'realizada': dropValueState == "NO REALIZADA" ? 0 : 1,
                'fechaExpiracion': txtConExpDate.text,
                'fechaRecordatorio': recordar,
                'idProfe': dropDownValue!.idProfe,
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
            agendaDB!.UPDATE_TAREA('tblTareas', {
              'idTarea': widget.tareaModel!.idTarea,
              'nomTarea': txtConName.text,
              'desTarea': txtConDsc.text,
              'realizada': dropValueState == "NO REALIZADA" ? 0 : 1,
              'fechaExpiracion': txtConExpDate.text,
              'fechaRecordatorio': recordar,
              'idProfe': dropDownValue!.idProfe,
            }).then((value) {
              var msj = (value > 0)
                  ? 'La actualización fue exitosa'
                  : 'Ocurrio un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          }
          GlobalValues.flagTarea.value = !GlobalValues.flagTarea.value;
        },
        child: const Text("Guardar Tarea"));

    return Scaffold(
      appBar: AppBar(
          title: widget.tareaModel == null
              ? Text('Add Tarea')
              : Text('Update Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            txtNameTarea,
            space,
            txtDscTarea,
            space,
            ddBProfe,
            space,
            dateInput,
            space,
            ddbStatus,
            space,
            btnGuardar
          ],
        ),
      ),
    );
  }
}
