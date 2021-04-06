import 'package:flutter/material.dart';

class InputDate extends StatefulWidget {
  final Function dateSelection;

  InputDate({
    Key key,
    @required this.dateSelection,
  }) : super(key: key);

  @override
  _InputDateState createState() => _InputDateState();
}

class _InputDateState extends State<InputDate> {
  bool _pressedHoje = false;
  bool _pressedOntem = false;
  bool _pressedOutro = false;

  final textNotPressed = TextStyle(
    color: Colors.grey[700],
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  final textPressed = TextStyle(
    color: Colors.white,
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
            primary:
                _pressedHoje ? Colors.white.withOpacity(0.2) : Colors.white,
            shadowColor: Colors.black.withOpacity(1),
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
            if (_pressedHoje) widget.dateSelection("Hoje");
          },
          child: Text(
            "Hoje",
            style: _pressedHoje ? textPressed : textNotPressed,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary:
                _pressedOntem ? Colors.white.withOpacity(0.2) : Colors.white,
            shadowColor: Colors.black.withOpacity(1),
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
            if (_pressedOntem) widget.dateSelection("Ontem");
          },
          child: Text(
            "Ontem",
            style: _pressedOntem ? textPressed : textNotPressed,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary:
                _pressedOutro ? Colors.white.withOpacity(0.2) : Colors.white,
            shadowColor: Colors.black.withOpacity(1),
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
            if (_pressedOutro) widget.dateSelection("Outros");
          },
          child: Text(
            "Outros...",
            style: _pressedOutro ? textPressed : textNotPressed,
          ),
        ),
      ],
    );
  }
}
