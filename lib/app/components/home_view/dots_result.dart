import 'package:flutter/material.dart';

class DotsResult extends StatelessWidget {
  final int currentIndex;

  const DotsResult({Key key, @required this.currentIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: 7,
          width: 7,
          decoration: BoxDecoration(
            color: getColor(0),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: 6,
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: 7,
          width: 7,
          decoration: BoxDecoration(
            color: getColor(1),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  // Method for choosing dot color
  Color getColor(int index) {
    return index == currentIndex ? Colors.white : Colors.white38;
  }
}
