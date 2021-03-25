import 'package:flutter/material.dart';

import 'views/home_view.dart';

void main() => runApp(AppWidget());

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[600],
        primaryColor: Colors.grey[800],
      ),
      debugShowCheckedModeBanner: false,
      title: "Gastos com gás",
      home: HomeView(),
    );
  }
}
