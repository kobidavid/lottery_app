import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  TestPage(MaterialApp materialApp);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(theme: ThemeData(brightness: Brightness.dark),home: Scaffold(body: Center(child: Text('sss'))));
  }
}
