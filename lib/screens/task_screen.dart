import 'package:app1flutter/database/agenda_db.dart';
import 'package:app1flutter/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/add'),
              icon: const Icon(Icons.task))
        ],
      ),
      body: FutureBuilder(
        future: agendaDB!.GETALLTASK(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: 5, // snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return const Text('Hola Amigos');
                });
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Somenthing Went Wrong'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }
        },
      ),
    );
  }
}
