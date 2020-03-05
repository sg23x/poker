import 'package:flutter/material.dart';
import 'package:poker/UI/playerGame.dart';

TextEditingController cont = new TextEditingController();
String username;

class PlayerLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: cont,
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (val) {
                    username = val;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          RaisedButton(
            child: Text(
              "PLAY",
            ),
            onPressed: () {
              cont.clear();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => PlayerGame(
                    username,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
