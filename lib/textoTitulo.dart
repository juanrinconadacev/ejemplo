import 'package:flutter/material.dart';

class TextoTitulo extends StatelessWidget {
  final String _texto;

  TextoTitulo(this._texto);

  @override
  Widget build(BuildContext context) {
    return Text(_texto,
        style: TextStyle(
          fontSize: 40,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 6
            ..color = Colors.blue[700]!,
        ));
  }
}
