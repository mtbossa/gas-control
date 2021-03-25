import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class InputGasPrice extends StatelessWidget {
  MoneyMaskedTextController gasPriceController = MoneyMaskedTextController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Text(
              "R\$",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
          Container(
            width: 55,
            child: TextFormField(
              maxLength: 6,
              style: TextStyle(
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding:  EdgeInsets.symmetric(vertical: -2),
                isDense: true,
                counterText: "",
                border: InputBorder.none,
              ),
              controller: gasPriceController, // TODO adjust controller (later)
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }
}
