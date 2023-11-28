import 'package:app1flutter/assets/global_values.dart';
import 'package:app1flutter/database/agenda_db.dart';
import 'package:app1flutter/models/carrera_model.dart';
import 'package:app1flutter/models/profesor_model.dart';
import 'package:app1flutter/screens/add_profesor.dart';
import 'package:app1flutter/screens/add_task.dart';
import 'package:flutter/material.dart';

Widget profesorWidget(ProfesorModel profesor, BuildContext context) {
  AgendaDB agendaDB = AgendaDB();
  return FutureBuilder(
      future: agendaDB.GETNOMCARRBYID(profesor.idCarrera!),
      builder: (BuildContext context, AsyncSnapshot<CarreraModel> snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(color: Color.fromARGB(255, 113, 89, 3)),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(profesor.nomProfe!),
                    Text(snapshot.data!.nomCarrera!,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 12)),
                    Text(profesor.email!)
                  ],
                ),
                Expanded(child: Container()),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddProfesor(profesorModel: profesor))),
                      child: Image.asset(
                        'assets/update.png',
                        height: 30,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Mensaje del sistema?'),
                                content: Text('Seguro que desea eliminar?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        agendaDB!.DELETE_PROFESOR(
                                            'tblProfesor', profesor.idProfe!);
                                        Navigator.pop(context);

                                        GlobalValues.flagTask.value =
                                            !GlobalValues.flagTask.value;
                                      },
                                      child: Text('Si')),
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('No')),
                                ],
                              );
                            });
                      },
                      icon: Image.asset(
                        'assets/delete.png',
                        height: 50,
                      ),
                    ),
                    //IconButton(onPressed: () {}, icon: Icon(Icons.delete))
                  ],
                )
              ],
            ),
          );
        } else {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something Was Wrong"),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
      });
}
