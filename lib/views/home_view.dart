import 'package:flutter/material.dart';
import 'package:gas_mvc/app/components/home_view/container_values.dart';
import 'package:gas_mvc/app/components/home_view/dots_result.dart';
import 'package:gas_mvc/app/components/home_view/page_view_result.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex; // Current index of result view

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Controle gás",
        ),
      ),
      body: ListView(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    ContainerValues(),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("CALCULAR"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "RESULTADOS",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    PageViewResult(
                      onChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });                        
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    DotsResult(
                      currentIndex: _currentIndex,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
