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

  atras() {
    Navigator.pop(context);
  }

  Future<void> getSentidoVida() async {
    Uri uri = Uri.parse('https://superapi.netlify.app/api/meaningoflife');
    final response = await http.get(uri);
    _resultado = int.parse(response.body);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSentidoVida();
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
        floatingActionButton: Padding(
          padding: EdgeInsets.all(30),
          child: TextButton(
            onPressed: atras,
            child: const Text('< Atrás'),
          ),
        ),
        body: Column(
          children: [
            TextoTitulo('Personas'),
            if(_resultado != -1) Text('El sentido de la vida es $_resultado'),
            ListView.builder(
                itemCount: personas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(personas[index].nombre),
                    subtitle: Text('${personas[index].edad} años'),
                  );
                },
                shrinkWrap: true)
          ],
        ));
  }
}
