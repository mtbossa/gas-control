import 'package:flutter/material.dart';

class InputDate extends StatelessWidget {
  final Function dateSelection;
  final String dateText;
  final String datePressed;

  InputDate({
    Key key,
    @required this.dateSelection,
    @required this.dateText,
    @required this.datePressed,
  }) : super(key: key);

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
            primary: (datePressed == "Hoje")
                ? Colors.white.withOpacity(0.2)
                : Colors.white,
            shadowColor: Colors.black.withOpacity(1),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: () {
            dateSelection("Hoje");
          },
          child: Text(
            "Hoje",
            style:  (datePressed == "Hoje") ? textPressed : textNotPressed,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: (datePressed == "Ontem")
                ? Colors.white.withOpacity(0.2)
                : Colors.white,
            shadowColor: Colors.black.withOpacity(1),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: () {
            dateSelection("Ontem");
          },
          child: Text(
            "Ontem",
            style:(datePressed == "Ontem") ? textPressed : textNotPressed,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: (datePressed == "Outros")
                ? Colors.white.withOpacity(0.2)
                : Colors.white,
            shadowColor: Colors.black.withOpacity(1),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: () {
            dateSelection("Outros");
          },
          child: Text(
            "$dateText",
            style: (datePressed == "Outros") ? textPressed : textNotPressed,
          ),
        ),
      ],
    );
  }
}
