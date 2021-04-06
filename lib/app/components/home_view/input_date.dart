import 'package:flutter/material.dart';

class InputDate extends StatefulWidget {

  
  InputDate({
    Key key,
  }) : super(key: key);

  @override
  _InputDateState createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  bool _pressedHoje = false;
  bool _pressedOntem = false;
  bool _pressedOutro = false;

  final textStyleValue = TextStyle(
    color: Colors.grey[700],
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: _pressedHoje
                ? Colors.grey[700].withOpacity(0.6)
                : Colors.grey[700].withOpacity(0.1),
            shadowColor: Colors.black.withOpacity(0.4),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: () {
            setState(() {
              _pressedHoje = !_pressedHoje;
              _pressedOntem = false;
              _pressedOutro = false;
            });
          },
          child: Text(
            "Hoje",
            style: textStyleValue,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: _pressedOntem
                ? Colors.grey[700].withOpacity(0.6)
                : Colors.grey[700].withOpacity(0.1),
            shadowColor: Colors.black.withOpacity(0.4),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: () {
            setState(() {
              _pressedHoje = false;
              _pressedOntem = !_pressedOntem;
              _pressedOutro = false;
            });
          },
          child: Text(
            "Ontem",
            style: textStyleValue,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: _pressedOutro
                ? Colors.grey[700].withOpacity(0.6)
                : Colors.grey[700].withOpacity(0.1),
            shadowColor: Colors.black.withOpacity(0.4),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: () {
            setState(() {
              _pressedHoje = false;
              _pressedOntem = false;
              _pressedOutro = !_pressedOutro;
            });
          },
          child: Text(
            "Outro...",
            style: textStyleValue,
          ),
        ),
      ],
    );
  }
}
