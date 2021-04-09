import 'package:flutter/material.dart';

class DisplayLeituraValue extends StatelessWidget {
  final Function handler;
  final String title;

  const DisplayLeituraValue({
    Key key,
    @required this.handler,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            handler(context),
            SizedBox(
              width: 5,
            ),
            Text(
              "m³",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ],
    );
  }
}
