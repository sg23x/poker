import 'package:flutter/material.dart';
import 'package:poker/UI/choicePage.dart';
import 'package:poker/UI/landing.dart';
import 'package:poker/UI/masterUsernames.dart';

main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Landing(),
    );
  }
}
