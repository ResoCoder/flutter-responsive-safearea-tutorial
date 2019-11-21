import 'package:flutter/material.dart';

import 'responsive_safe_area.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ResponsiveSafeArea(
          builder: (context, size) {
            return Container(
              decoration: BoxDecoration(color: Colors.green.shade200),
              alignment: Alignment.topCenter,
              height: size.height / 2,
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
