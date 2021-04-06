import 'dart:io';

import 'package:flutter/material.dart';

class InputGasValue extends StatelessWidget {
  // For focusing next TextField
  final FocusNode _focusNode = FocusNode();

  final TextEditingController newIntValueTextController;
  final TextEditingController newDecimalValueTextController;
  final defaultLocale = Platform.localeName;
  
  final textStyleValue = TextStyle(    
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );
  final textHintStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  InputGasValue({
    Key key,
    @required this.newIntValueTextController,
    @required this.newDecimalValueTextController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            shadowColor: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            elevation: 2,
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey[700].withOpacity(0.3),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 80,
                    child: TextField(
                      textDirection: TextDirection.rtl,
                      controller: newIntValueTextController,
                      style: textStyleValue,
                      onEditingComplete: (() => _focusNode.requestFocus()),
                      decoration: InputDecoration(
                        hintStyle: textHintStyle,
                        hintText: "00000",
                        hintTextDirection: TextDirection.rtl,
                        contentPadding: EdgeInsets.symmetric(vertical: -2),
                        isDense: true,
                        counterText: "",
                        border: InputBorder.none,
                      ),
                      maxLength: 5,
                      keyboardType: TextInputType.number,
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
              top: 10.0,
            ),
            child: dotOrComma(),
          ),
          Material(
            shadowColor: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            elevation: 2,
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey[700].withOpacity(0.3),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 60,
                    child: TextField(
                      textDirection: TextDirection.rtl,
                      controller: newDecimalValueTextController,
                      style: textStyleValue,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        hintStyle: textHintStyle,
                        hintText: "000",
                        hintTextDirection: TextDirection.ltr,
                        contentPadding: EdgeInsets.only(top: -2, bottom: -2),
                        isDense: true,
                        counterText: "",
                        border: InputBorder.none,
                      ),
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
