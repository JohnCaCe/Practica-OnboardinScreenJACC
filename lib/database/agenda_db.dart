import 'dart:async';
import 'dart:io';
import 'package:app1flutter/models/carrera_model.dart';
import 'package:app1flutter/models/profesor_model.dart';
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
    fechaExpiracion VARCHAR(100),
    fechaRecordatorio VARCHAR(100),
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

  Future<int> UPDATE_PROFE(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idProfe = ?', whereArgs: [data['idProfe']]);
  }

  Future<int> UPDATE_TAREA(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.update(tblName, data,
        where: 'idTarea = ?', whereArgs: [data['idTarea']]);
  }

  Future<int> DELETE(String tblName, int idTask) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'idTask = ?', whereArgs: [idTask]);
  }

  Future<int> DELETE_CARRERA(String tblName, int idCarrera) async {
    var conexion = await database;
    return conexion!
        .delete(tblName, where: 'idCarrera = ?', whereArgs: [idCarrera]);
  }

  Future<int> DELETE_PROFESOR(String tblName, int idProfe) async {
    var conexion = await database;
    return conexion!
        .delete(tblName, where: 'idProfe = ?', whereArgs: [idProfe]);
  }

  Future<int> DELETE_TAREA(String tblName, int idTarea) async {
    var conexion = await database;
    return conexion!
        .delete(tblName, where: 'idTarea = ?', whereArgs: [idTarea]);
  }

  Future<List<TareaModel>> GETALLTAREAS() async {
    var conexion = await database;
    var result = await conexion!.query('tblTarea');
    return result.map((tarea) => TareaModel.fromMap(tarea)).toList();
  }

  Future<List<CarreraModel>> GETALLCARRERAS() async {
    var conexion = await database;
    var result = await conexion!.query('tblCarrera');
    return result.map((carrera) => CarreraModel.fromMap(carrera)).toList();
  }

  Future<List<ProfesorModel>> GETALLPROFESOR() async {
    var conexion = await database;
    var result = await conexion!.query('tblProfesor');
    return result.map((profesor) => ProfesorModel.fromMap(profesor)).toList();
  }

  Future<List<Map<String, dynamic>>> GETALLNOMCARRERAS() async {
    var conexion = await database;
    return await conexion!.rawQuery('SELECT nomCarrera FROM tblCarrera');
  }

  Future<CarreraModel> GETNOMCARRBYID(int objectId) async {
    var conexion = await database;
    var result = await conexion!
        .query('tblCarrera', where: 'idCarrera = ?', whereArgs: [objectId]);
    return result.map((career) => CarreraModel.fromMap(career)).toList().first;
  }

  Future<ProfesorModel> GETNOMPROFEBYID(int objectId) async {
    var conexion = await database;
    var result = await conexion!
        .query('tblProfesor', where: 'idProfe = ?', whereArgs: [objectId]);
    return result
        .map((profesor) => ProfesorModel.fromMap(profesor))
        .toList()
        .first;
  }

  Future<ProfesorModel> GETTAREABYID(int objectId) async {
    var conexion = await database;
    var result = await conexion!
        .query('tblTarea', where: 'idTarea = ?', whereArgs: [objectId]);
    return result.map((tarea) => ProfesorModel.fromMap(tarea)).toList().first;
  }

  Future<List<Map<String, dynamic>>> GETIDCARRERA(String carrera) async {
    var conexion = await database;
    return await conexion!.rawQuery(
        'SELECT idCarrera FROM tblCarrera WHERE nomCarrera = ?', ['$carrera']);
  }

  Future<void> DELETEALL(table) async {
    var connection = await database;
    await connection!.delete(table, where: '1=1');
  }

  Future<List<TareaModel>> GETTAREASNOREALIZADAS() async {
    var connection = await database;
    var sql = "select * from tblTarea where realizada = 0";
    var result = await connection!.rawQuery(sql);
    return result.map((tarea) => TareaModel.fromMap(tarea)).toList();
  }

  Future<List<TareaModel>> GETTAREASFILTRADAS(String input, int? input2) async {
    var connection = await database;
    var sql = input2 != null
        ? "select * from tblTarea where nomTarea like '%$input%' and realizada = $input2"
        : "select * from tblTarea where nomTarea like '%$input%'";
    var result = await connection!.rawQuery(sql);
    return result.map((tarea) => TareaModel.fromMap(tarea)).toList();
  }
}
