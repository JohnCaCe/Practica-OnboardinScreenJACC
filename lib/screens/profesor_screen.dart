import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfesorScreen extends StatefulWidget {
  const ProfesorScreen({super.key});

  @override
  State<ProfesorScreen> createState() => _ProfesorScreenState();
}

class _ProfesorScreenState extends State<ProfesorScreen> {
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
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/AddProfe');
          },
          child: Icon(Icons.add)),
    );
  }
}
