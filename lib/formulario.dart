import 'package:ejemplo/listado.dart';
import 'package:ejemplo/persona.dart';
import 'package:ejemplo/textoTitulo.dart';
import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  const Formulario({super.key, required this.title});

  final String title;

  @override
  State<Formulario> createState() => _Formulario();
}

class _Formulario extends State<Formulario> {
  Persona persona = Persona('', 20);

  botonPulsado() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Listado()));
  }

  edadCambiada(double edad) {
    setState(() {
      persona.edad = edad.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrange[200],
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 100),
          child: Column(
            children: [
              TextoTitulo('Rellena los datos'),
              TextField(
                decoration: InputDecoration(hintText: 'Escribe tu nombre...'),
                onChanged: (text) {
                  setState(() {
                    persona.nombre = text;
                  });
                },
              ),
              persona.edad > 75
                  ? Text('Es usted viejo')
                  : Text('Es usted joven'),
              Slider(
                  value: persona.edad.toDouble(),
                  max: 150,
                  divisions: 150,
                  label: persona.edad.toString(),
                  onChanged: edadCambiada),
              if (persona.nombre.isNotEmpty)
                TextButton(onPressed: botonPulsado, child: Text('Aceptar')),
            ],
          ),
        ));
  }
}
