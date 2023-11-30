import 'package:ejemplo/listado.dart';
import 'package:ejemplo/persona.dart';
import 'package:ejemplo/textoTitulo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Formulario extends StatefulWidget {
  const Formulario({super.key});


  @override
  State<Formulario> createState() => _Formulario();
}

class _Formulario extends State<Formulario> {
  Persona persona = Persona('', 5);

  botonPulsado() {
    postRegistro();    
  }

  longitudCambiada(double longitud) {
    setState(() {
      persona.longitud = longitud.round();
    });
  }

  Future<void> postRegistro() async {
    Uri uri = Uri.parse('https://superapi.netlify.app/api/register');
    final cabeceras = { 'Content-Type': 'application/json; charset=UTF-8' };
    final cuerpoJSON = persona.toJSON();
    print('Enviando: $cuerpoJSON');
    final response = await http.post(uri, headers: cabeceras, body: cuerpoJSON);
    
    if (response.statusCode == 200) {
      atras();
    }    
  }

  atras() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrange[200],
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(30),
          child: TextButton(
            onPressed: atras,
            child: const Text('< Atrás'),
          )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
          child: Column(
            children: [
              TextoTitulo('Rellena los datos'),
              TextField(
                decoration: const InputDecoration(hintText: 'Escribe tu nombre...'),
                onChanged: (text) {
                  setState(() {
                    persona.nombre = text;
                  });
                },
              ),
              persona.longitud < 8
                  ? const Text('Tu contraseña es débil')
                  : const Text('Tu contraseña es fuerte'),
              Slider(
                  value: persona.longitud.toDouble(),
                  max: 20,
                  divisions: 20,
                  label: persona.longitud.toString(),
                  onChanged: longitudCambiada),
              if (persona.nombre.isNotEmpty)
                TextButton(onPressed: botonPulsado, child: Text('Aceptar')),
            ],
          ),
        ));
  }
}
