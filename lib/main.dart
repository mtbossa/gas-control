import 'package:flutter/material.dart';

import 'app/views/home_view.dart';

void main() => runApp(AppWidget());

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        textTheme: TextTheme(
          // For titles
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          // For display values
          bodyText2: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
          // Result values numbers
          headline1: TextStyle(
            color: Colors.greenAccent[400],
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[800],
        primaryColor: Colors.grey[600],
        fontFamily: "Montserrat",
      ),
      debugShowCheckedModeBanner: false,
      title: "Gastos com gás",
      home: HomeView(),
    );
  }
}
