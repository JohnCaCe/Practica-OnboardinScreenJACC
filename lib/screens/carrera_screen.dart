import 'package:app1flutter/assets/global_values.dart';
import 'package:app1flutter/database/agenda_db.dart';
import 'package:app1flutter/models/carrera_model.dart';
import 'package:app1flutter/widgets/CardCarreraWidget.dart';
import 'package:app1flutter/widgets/CardTaskWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CarreraScreen extends StatefulWidget {
  const CarreraScreen({super.key});

  @override
  State<CarreraScreen> createState() => _CarreraScreenState();
}

class _CarreraScreenState extends State<CarreraScreen> {
  TextEditingController txtConCarrera = TextEditingController();
  AgendaDB? agendaDB;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    final txtBuscar = TextFormField(
      controller: txtConCarrera,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), label: Text("Carrera")),
    );
    final ElevatedButton btnBuscar =
        ElevatedButton(onPressed: () {}, child: const Text("Buscar"));
    return Scaffold(
      appBar: AppBar(
        title: Text('Carreras'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/carreras').then((value) {
                    setState(() {});
                  }),
              icon: const Icon(Icons.search))
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: GlobalValues.flagTask,
          builder: (context, value, _) {
            return FutureBuilder(
              future: agendaDB!.GETALLCARRERAS(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<CarreraModel>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CardCarreraWidget(
                          carreraModel: snapshot.data![index],
                          agendaDB: agendaDB,
                        );
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
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/AddCarr');
          },
          child: Icon(Icons.add)),
    );
  }
}
