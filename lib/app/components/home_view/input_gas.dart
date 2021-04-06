import 'dart:io';

import 'package:flutter/material.dart';

class InputGas extends StatelessWidget {
  final TextEditingController newIntValueTextController;
  final TextEditingController newDecimalValueTextController;
  final defaultLocale = Platform.localeName;

  final textHintStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  final textStyleValue = TextStyle(
    color: Colors.grey[700],
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

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
          width: 100,
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
              style: textStyleValue,
              decoration: InputDecoration(
                hintStyle: textHintStyle,
                hintText: "00000",
                counterText: "",
                contentPadding: const EdgeInsets.only(
                  right: -10,
                  top: -10,
                  bottom: -10,
                  left: -8,
                ),
                fillColor: Colors.grey[700].withOpacity(0.3),
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
            left: 3.0,
            right: 3.0,
            top: 20.0,
          ),
          child: dotOrComma(),
        ),
        Container(
          width: 65,
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
              style: textStyleValue,
              decoration: InputDecoration(
                hintStyle: textHintStyle,
                hintText: "000",
                counterText: "",
                contentPadding: const EdgeInsets.only(
                  right: -10,
                  top: -10,
                  bottom: -10,
                  left: -8,
                ),
                fillColor: Colors.grey[700].withOpacity(0.3),
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
      ],
    );
  }

  Text dotOrComma() {
    if (defaultLocale == "pt_BR") {
      return Text(
        ",",
        style: textStyleValue,
      );
    } else {
      return Text(
        ".",
        style: textStyleValue,
      );
    }
  }
}
