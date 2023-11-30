
import 'dart:convert';
import 'dart:math';

class Persona {
  String nombre;
  int longitud;

  Persona(this.nombre, this.longitud);

  String toJSON() {
    return json.encode({"user" : nombre, "pass" : _generarPass()});
  }

  String _generarPass() {
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!¡¿?+-_%';
    final random = Random();
    String pass = '';
    for (var i = 0; i < longitud; i++) {
      pass = pass + chars[random.nextInt(chars.length)];
    }
    return pass;
  }
}