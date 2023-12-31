import 'package:app1flutter/assets/global_values.dart';
import 'package:app1flutter/database/agenda_db.dart';
import 'package:app1flutter/models/profesor_model.dart';
import 'package:app1flutter/models/task_model.dart';
import 'package:app1flutter/models/task_model.dart';
import 'package:app1flutter/screens/add_tarea.dart';
import 'package:app1flutter/screens/add_task.dart';
import 'package:flutter/material.dart';

Widget tareaWidget(TareaModel tarea, BuildContext context) {
  AgendaDB? agendaDB = AgendaDB();
  return FutureBuilder(
      future: agendaDB.GETNOMPROFEBYID(tarea.idProfe!),
      builder: (BuildContext context, AsyncSnapshot<ProfesorModel> snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(color: Color.fromARGB(255, 113, 89, 3)),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(tarea.nomTarea!),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(tarea.desTarea!),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(snapshot.data!.nomProfe!)
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
                                  AddTarea(tareaModel: tarea))),
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
                                        agendaDB!.DELETE_TAREA(
                                            'tblTarea', tarea.idTarea!);
                                        Navigator.pop(context);

                                        GlobalValues.flagTarea.value =
                                            !GlobalValues.flagTarea.value;
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
              child: Text("Algo salio mal"),
            );
          } else {
            return const CircularProgressIndicator();
          }
        }
      });
  /**/
}
