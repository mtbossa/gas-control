import 'package:flutter/material.dart';

class DisplayLeituraValue extends StatelessWidget {
  final Function valueHandler;
  final Function dateHandler;
  final String title;

  const DisplayLeituraValue({
    Key key,
    @required this.valueHandler,
    @required this.title,
    @required this.dateHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Center(
            child: dateHandler(context, title),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                valueHandler(context, title),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "m³",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
