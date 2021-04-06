import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class InputPrice extends StatelessWidget {
  final MoneyMaskedTextController gasPriceController;

  final textHintStyle = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  final textStyleValue = TextStyle(
    color: Colors.grey[700],
    fontSize: 25,
    fontWeight: FontWeight.w600,
  );

  InputPrice({
    Key key,
    this.gasPriceController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Material(
        shadowColor: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        elevation: 2,
        child: TextFormField(
          maxLength: 6,
          controller: gasPriceController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          style: textStyleValue,
          decoration: InputDecoration(
            counterText: "",
            contentPadding: const EdgeInsets.all(-10),
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
    );
  }
}