import 'package:app1flutter/assets/global_values.dart';
import 'package:app1flutter/database/agenda_db.dart';
import 'package:app1flutter/models/profesor_model.dart';
import 'package:app1flutter/widgets/CardProfesorWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfesorScreen extends StatefulWidget {
  const ProfesorScreen({super.key});

  @override
  State<ProfesorScreen> createState() => _ProfesorScreenState();
}

class _ProfesorScreenState extends State<ProfesorScreen> {
  AgendaDB? agendaDB;
  TextEditingController conBuscar = TextEditingController();
  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profesores'),
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
          valueListenable: GlobalValues.flagProfesor,
          builder: (context, value, _) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Search",
                    ),
                    controller: conBuscar,
                    onChanged: (text) {
                      GlobalValues.flagProfesor.value =
                          !GlobalValues.flagProfesor.value;
                    },
                  ),
                ),
                Expanded(
                    child: FutureBuilder(
                  future: agendaDB!.GETALLPROFESOR(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ProfesorModel>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return profesorWidget(
                                snapshot.data![index], context);
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
                ))
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/AddProfe');
          },
          child: Icon(Icons.add)),
    );
  }
}
