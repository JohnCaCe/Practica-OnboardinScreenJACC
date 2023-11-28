import 'package:app1flutter/assets/global_values.dart';
import 'package:app1flutter/database/agenda_db.dart';
import 'package:app1flutter/models/carrera_model.dart';
import 'package:app1flutter/models/carrera_model.dart';
import 'package:app1flutter/screens/add_carrera.dart';
import 'package:flutter/material.dart';

class CardCarreraWidget extends StatefulWidget {
  CardCarreraWidget({super.key, required this.carreraModel, this.agendaDB});

  CarreraModel carreraModel;
  AgendaDB? agendaDB;

  @override
  State<CardCarreraWidget> createState() => _CardCarreraWidgetState();
}

class _CardCarreraWidgetState extends State<CardCarreraWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: Color.fromARGB(255, 35, 4, 189)),
      child: Row(
        children: [
          Column(
            children: [
              Text(widget.carreraModel.nomCarrera!),
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
                            AddCarrera(carreraModel: widget.carreraModel))),
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
                                  widget.agendaDB!.DELETE_CARRERA('tblCarrera',
                                      widget.carreraModel.idCarrera!);
                                  Navigator.pop(context);

                                  GlobalValues.flagCarrera.value =
                                      !GlobalValues.flagCarrera.value;
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
  }
}
