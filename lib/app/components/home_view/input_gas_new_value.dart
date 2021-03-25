import 'package:flutter/material.dart';

class InputGasValue extends StatelessWidget {
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          child: TextField(
            textDirection: TextDirection.rtl,
            // TODO add controller
            style: TextStyle(
              fontSize: 17,
            ),
            onEditingComplete: (() => _focusNode.requestFocus()),
            decoration: InputDecoration(
              hintText: "00000",
              contentPadding:  EdgeInsets.symmetric(vertical: -2),
              isDense: true,
              counterText: "",
              border: InputBorder.none,
            ),
            maxLength: 5,
            keyboardType: TextInputType.number,
          ),
        ),
        Text(
          ",",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: Container(
            width: 32,
            child: TextField(
              textDirection: TextDirection.rtl,
              // TODO add controller
              style: TextStyle(
                fontSize: 17,
              ),
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: "000",
                contentPadding:  EdgeInsets.symmetric(vertical: -2),
                isDense: true,
                counterText: "",
                border: InputBorder.none,
              ),
              maxLength: 3,
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          "m³",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}
