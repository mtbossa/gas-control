import 'package:flutter/material.dart';

class PageViewResult extends StatelessWidget {
  final ValueChanged<int> onChanged;

  const PageViewResult({Key key, @required this.onChanged}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        width: 100,
        height: 70,
        child: PageView(
          onPageChanged: onChanged,
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              // decoration: BoxDecoration(
              //   color: Colors.white,
              //   borderRadius: BorderRadius.all(
              //     Radius.circular(12),
              //   ),
              // ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "20,3", // TODO quantidade gasta
                    style: TextStyle(fontSize: 25, color: Colors.green),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: Text(
                      "kg/gás",
                      style: TextStyle(fontSize: 25, color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "130,00", // TODO valor gasto
                    style: TextStyle(fontSize: 25, color: Colors.green),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      "R\$",
                      style: TextStyle(fontSize: 25, color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
