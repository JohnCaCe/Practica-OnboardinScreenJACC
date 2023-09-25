import 'package:app1flutter/assets/global_values.dart';
import 'package:app1flutter/database/agenda_db.dart';
import 'package:app1flutter/models/task_model.dart';
import 'package:flutter/material.dart';

class CardTaskWidget extends StatefulWidget {
  CardTaskWidget({super.key, required this.taskModel, this.agendaDB});

  TaskModel taskModel;
  AgendaDB? agendaDB;

  @override
  State<CardTaskWidget> createState() => _CardTaskWidgetState();
}

class _CardTaskWidgetState extends State<CardTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.cyanAccent),
      child: Row(
        children: [
          Column(
            children: [
              Text(widget.taskModel.nameTask!),
              Text(widget.taskModel.descTask!)
            ],
          ),
          Expanded(child: Container()),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Mensaje del sistema?'),
                          content: Text('Seguro que desea eliminar?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  widget.agendaDB!.DELETE(
                                      'tblTareas', widget.taskModel.idTask!);
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
                child: Image.asset(
                  'assets/tecnoimg.png',
                  height: 50,
                ),
              ),
              //IconButton(onPressed: () {}, icon: Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
