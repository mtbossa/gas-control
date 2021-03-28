import 'package:flutter/material.dart';

class InputGasValue extends StatelessWidget {
  // For focusing next TextField
  final FocusNode _focusNode = FocusNode();

  final TextEditingController newIntValueTextController;
  final TextEditingController newDecimalValueTextController;

  InputGasValue({
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
          width: 70,
          child: TextField(
            textDirection: TextDirection.rtl,
            controller: newIntValueTextController,
            style: TextStyle(
              fontSize: 17,
            ),
            onEditingComplete: (() => _focusNode.requestFocus()),
            decoration: InputDecoration(
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
        Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: Text(
            ".",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 1.0),
          child: Container(
            width: 38,
            child: TextField(
              textDirection: TextDirection.rtl,
              controller: newDecimalValueTextController,
              style: TextStyle(
                fontSize: 17,
              ),
              focusNode: _focusNode,
              decoration: InputDecoration(
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
