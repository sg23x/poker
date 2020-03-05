import 'package:flutter/material.dart';
import 'package:poker/UI/widgets/choiceRow.dart';

class ChoicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ChoiceRow(),
        ],
      ),
    );
  }
}
