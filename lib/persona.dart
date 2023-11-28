
import 'dart:convert';

class Persona {
  String nombre;
  int edad;

  Persona(this.nombre, this.edad);

  String toJSON() {
    return json.encode({"user" : nombre, "pass" : edad.toString()});
  }
}