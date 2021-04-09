import 'package:flutter/material.dart';

import 'app/views/home_view.dart';

void main() => runApp(AppWidget());

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: Colors.grey[800],
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        textTheme: TextTheme(
          // For Leitura Anterior and Leitura Atual and input text
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
          // Warning about number os leituras
          bodyText2: TextStyle(
            fontFamily: "OpenSans",
            color: Colors.white,
            fontSize: 15,
          ),

          // Result values numbers
          headline1: TextStyle(
            color: Colors.greenAccent[400],
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
          // Leitura value
          headline2: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
          // For result type
          headline3: TextStyle(
            color: Colors.grey[800],
            fontSize: 30,
          ),
          // For inside icons type
          headline4: TextStyle(
            color: Colors.grey[800],
            fontSize: 15,
            fontWeight: FontWeight.w600,
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
