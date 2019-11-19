import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // Builder for the ability to access the MediaQuery through an InheritedWidget
        body: Builder(
          builder: (context) {
            return Container(
              decoration: BoxDecoration(color: Colors.green.shade200),
              alignment: Alignment.topCenter,
              // Using media query is fine now, we're really dealing with the whole screen
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                children: <Widget>[
                  Text(
                    "Let's get",
                    style: Theme.of(context).textTheme.display1,
                  ),
                  Text(
                    "RESPONSIVE",
                    style: Theme.of(context).textTheme.display3,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
