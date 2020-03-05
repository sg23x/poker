import 'package:flutter/material.dart';

class ChoiceRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          child: Text(
            "DEALER",
          ),
          onPressed: () {},
        ),
        RaisedButton(
          child: Text(
            "PLAYER",
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
