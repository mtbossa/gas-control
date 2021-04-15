import 'package:flutter/material.dart';
import 'package:showcaseview/showcase.dart';

class CustomShowcaseWidget extends StatelessWidget {
  final Widget child;
  final String description;
  final GlobalKey globalKey;

  const CustomShowcaseWidget({
    Key key,
    @required this.description,
    @required this.globalKey,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Showcase(
        contentPadding: EdgeInsets.all(10),
        showcaseBackgroundColor: Colors.white,
        key: globalKey,
        child: child,
        description: description,
        descTextStyle: TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
      );
}
