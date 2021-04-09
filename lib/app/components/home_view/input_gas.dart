import 'dart:io';

import 'package:flutter/material.dart';

class InputGas extends StatelessWidget {
  final TextEditingController newIntValueTextController;
  final TextEditingController newDecimalValueTextController;
  final defaultLocale = Platform.localeName;

  InputGas({
    Key key,
    @required this.newIntValueTextController,
    @required this.newDecimalValueTextController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120,
          child: Material(
            shadowColor: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            elevation: 2,
            child: TextFormField(
              maxLength: 5,
              textDirection: TextDirection.ltr,
              controller: newIntValueTextController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.white54,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                hintText: "00000",
                counterText: "",
                contentPadding: const EdgeInsets.only(
                  right: -10,
                  top: -10,
                  bottom: -10,
                  left: -8,
                ),
                fillColor: Colors.black,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 15.0,
            right: 2.0,
            left: 2.0,
          ),
          child: dotOrComma(),
        ),
        Container(
          width: 75,
          child: Material(
            shadowColor: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            elevation: 2,
            child: TextFormField(
              maxLength: 3,
              textDirection: TextDirection.ltr,
              controller: newDecimalValueTextController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.white54,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
                hintText: "000",
                counterText: "",
                contentPadding: const EdgeInsets.only(
                  right: -10,
                  top: -10,
                  bottom: -10,
                  left: -8,
                ),
                fillColor: Colors.redAccent,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              "m³",
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
      ],
    );
  }

  Text dotOrComma() {
    if (defaultLocale == "pt_BR") {
      return Text(
        ",",
        style: TextStyle(
          color: Colors.white,
          fontSize: 35,
          fontWeight: FontWeight.w600,
        ),
      );
    } else {
      return Text(
        ".",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }
}
