class TaskModel {
  int? idTask;
  String? nameTask;
  String? descTask;
  String? stateTask;

  TaskModel({this.idTask, this.nameTask, this.descTask, this.stateTask});
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
        idTask: map['idTask'],
        descTask: map['descTask'],
        nameTask: map['nameTask'],
        stateTask: map['stateTask']);
  }
}
