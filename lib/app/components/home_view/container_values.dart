import 'package:flutter/material.dart';

import 'input_gas_new_value.dart';
import 'input_gas_price.dart';

class ContainerValues extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Leitura atual",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Text(
                // TODO must be final GasModel.newAtualGasValue
                "12345,678 m³",
                style: TextStyle(
                  color: Colors.green[900],
                  fontSize: 17,
                ),
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                  left: 8.0,
                  bottom: 8.0,
                ),
                child: Text(
                  "Nova leitura",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              InputGasValue(),
            ],
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:const EdgeInsets.only(
                  right: 8.0,
                  left: 8.0,
                  bottom: 8.0,
                ),
                child: Text(
                  "Preço kg/gás",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              InputGasPrice(),
            ],
          ),
        ],
      ),
    );
  }
}
