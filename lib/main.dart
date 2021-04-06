import 'package:flutter/material.dart';

import 'app/views/home_view.dart';

void main() => runApp(AppWidget());

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        hintColor: Colors.grey[700].withOpacity(0.2),
        scaffoldBackgroundColor: Colors.white10.withOpacity(0.95),
        primaryColor: Colors.white,
        fontFamily: "Oswald",
      ),
      debugShowCheckedModeBanner: false,
      title: "Gastos com gás",
      home: HomeView(),
    );
  }
}
