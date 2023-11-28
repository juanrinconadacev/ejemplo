import 'dart:convert';

import 'package:ejemplo/listado.dart';
import 'package:ejemplo/persona.dart';
import 'package:ejemplo/textoTitulo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Formulario extends StatefulWidget {
  const Formulario({super.key, required this.title});

  final String title;

  @override
  State<Formulario> createState() => _Formulario();
}

class _Formulario extends State<Formulario> {
  Persona persona = Persona('', 20);

  botonPulsado() {
    postRegistro();    
  }

  edadCambiada(double edad) {
    setState(() {
      persona.edad = edad.round();
    });
  }

  Future<void> postRegistro() async {
    Uri uri = Uri.parse('https://superapi.netlify.app/api/register');
    final cabeceras = { 'Content-Type': 'application/json; charset=UTF-8' };
    final cuerpoJSON = persona.toJSON();
    final response = await http.post(uri, headers: cabeceras, body: cuerpoJSON);
    
    if (response.statusCode == 200) {
      Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Listado()));
    }    
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
