import 'package:flutter/material.dart';

class TareaModel {
  int? idTarea;
  String? nomTarea;
  String? fechaExpiracion;
  String? fechaRecordatorio;
  String? desTarea;
  int? realizada;
  int? idProfe;

  TareaModel(
      {this.idTarea,
      this.nomTarea,
      this.fechaExpiracion,
      this.fechaRecordatorio,
      this.desTarea,
      this.realizada,
      this.idProfe});

  factory TareaModel.fromMap(Map<String, dynamic> map) {
    return TareaModel(
        idTarea: map['idTarea'],
        nomTarea: map['nomTarea'],
        fechaExpiracion: map['fechaExpiracion'],
        fechaRecordatorio: map['fechaRecordatorio'],
        desTarea: map['desTarea'],
        realizada: map['realizada'],
        idProfe: map['idProfe']);
  }
}
