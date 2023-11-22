import 'package:ejemplo/persona.dart';
import 'package:flutter/material.dart';

class Listado extends StatefulWidget {
  const Listado({super.key});

  @override
  State<Listado> createState() => _Listado();
}

class _Listado extends State<Listado> {
  atras() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var personas = [
      Persona("Pepe", 25),
      Persona("Roberto", 50),
      Persona("Javiera", 80)
    ];

    return Scaffold(
        backgroundColor: Colors.deepOrange[200],
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: TextButton(
          onPressed: atras,
          child: const Text('< Atrás'),
        ),
        body: ListView.builder(
          itemCount: personas.length,
          itemBuilder: (context, index) {
          return ListTile(
            title: Text(personas[index].nombre),
            subtitle: Text(personas[index].edad.toString() + ' años'),
          );
        }),);
  }
}
