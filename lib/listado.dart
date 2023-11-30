import 'dart:convert';

import 'package:ejemplo/formulario.dart';
import 'package:ejemplo/persona.dart';
import 'package:ejemplo/textoTitulo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Listado extends StatefulWidget {
  const Listado({super.key});

  @override
  State<Listado> createState() => _Listado();
}

class _Listado extends State<Listado> {
  int _resultado = -1;
  List<Persona> _personas = [];

  nuevoUsuario() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Formulario()));
  }

  Future<void> getSentidoVida() async {
    Uri uri = Uri.parse('https://superapi.netlify.app/api/meaningoflife');
    final response = await http.get(uri);
    _resultado = int.parse(response.body);
    setState(() {});
  }

  Future<void> getUsuarios() async {
    Uri uri = Uri.parse('https://superapi.netlify.app/api/users');
    final response = await http.get(uri);
    List<dynamic> users = json.decode(response.body);
    for (var user in users) {
      _personas.add(Persona(user, user.length));
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSentidoVida();
    getUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrange[200],
        floatingActionButton: FloatingActionButton(
            onPressed: nuevoUsuario, child: const Icon(Icons.add)),
        body: Column(
          children: [
            TextoTitulo('Personas'),
            if (_resultado != -1) Text('El sentido de la vida es $_resultado'),
            Expanded(
                child: ListView.builder(
                    itemCount: _personas.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_personas[index].nombre),
                        subtitle: Text('${_personas[index].longitud} letras'),
                      );
                    }))
          ],
        ));
  }
}
