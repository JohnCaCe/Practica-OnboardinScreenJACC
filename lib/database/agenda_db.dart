import 'dart:async';
import 'dart:io';
import 'package:app1flutter/models/carrera_model.dart';
import 'package:app1flutter/models/task_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AgendaDB {
  static const nameDB = 'AGENDADB';
  static const versionDB = 1;

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    return _database = await _initDatabase();
  }

  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return openDatabase(pathDB, version: versionDB, onCreate: _createTables);
  }

  FutureOr<void> _createTables(Database db, int version) {
    String query = '''CREATE TABLE tblTareas(idTask INTEGER PRIMARY KEY, 
    nameTask VARCHAR(50), 
    descTask VARCHAR(50), 
    stateTask BYTE)''';
    db.execute(query);
    String query2 = '''CREATE TABLE tblCarrera(idCarrera INTEGER PRIMARY KEY, 
    nomCarrera VARCHAR(50))''';
    db.execute(query2);
    String query3 = '''CREATE TABLE tblProfesor(idProfe INTEGER PRIMARY KEY, 
    nomProfe VARCHAR(50),
    idCarrera INTEGER,
    email VARCHAR(30),
    FOREIGN KEY (idCarrera) REFERENCES tblCarrera(idCarrera))''';
    db.execute(query3);
    String query4 = '''CREATE TABLE tblTarea(idTarea INTEGER PRIMARY KEY, 
    nomTarea VARCHAR(50),
    fechaExpiracion DateTime,
    fechaRecordatorio DateTime,
    desTarea VARCHAR(100),
    realizada INTEGER,
    idProfe INTEGER,
    FOREIGN KEY (idProfe) REFERENCES tblProfesor(idProfe))''';
    db.execute(query4);
  }

  Future<int> INSERT(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> UPDATE(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idTask = ?', whereArgs: [data['idTask']]);
  }

  Future<int> UPDATE_CARRERA(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idCarrera = ?', whereArgs: [data['idCarrera']]);
  }

  Future<int> DELETE(String tblName, int idTask) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'idTask = ?', whereArgs: [idTask]);
  }

  Future<List<TaskModel>> GETALLTASK() async {
    var conexion = await database;
    var result = await conexion!.query('tblTareas');
    return result.map((task) => TaskModel.fromMap(task)).toList();
  }

  Future<List<CarreraModel>> GETALLCARRERAS() async {
    var conexion = await database;
    var result = await conexion!.query('tblCarrera');
    return result.map((carrera) => CarreraModel.fromMap(carrera)).toList();
  }
}
