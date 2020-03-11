import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poker/UI/masterGame.dart';
import 'package:poker/api.dart';

class MasterUsernames extends StatefulWidget {
  @override
  _MasterUsernamesState createState() => _MasterUsernamesState();
}

class _MasterUsernamesState extends State<MasterUsernames> {
  void addUser(String user) async {
    username != ""
        ? await Firestore.instance.collection("player").add(
            {
              'username': user,
              'label': labels[players.length],
            },
          )
        : null;
  }

  void clearUsers() async {
    await Firestore.instance.collection('player').getDocuments().then(
      (snapshot) {
        for (DocumentSnapshot ds in snapshot.documents) {
          ds.reference.delete();
        }
      },
    );
  }

  void uploadCardCode() async {
    await Firestore.instance.collection("cards").document('one').updateData(
      {
        "cardCode": cardCode,
        "isTexas": isTexas,
        "totalPlayers": totalPlayers,
      },
    );
  }

  String username;
  String data;
  String url;
  String cardCode;
  int totalPlayers;
  List labels = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  TextEditingController cont = new TextEditingController();
  List<String> players = [];
  bool isOmaha = false;
  bool isTexas = true;
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        players.clear();

        if (!snapshot.hasData) {
          return Scaffold();
        }
        for (DocumentSnapshot doc in snapshot.data.documents) {
          players.insert(
            players.length,
            doc['username'],
          );
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          resizeToAvoidBottomPadding: false,
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
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
                        this.username = val;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      addUser(username);
                      cont.clear();
                      setState(
                        () {
                          username = "";
                        },
                      );
                    },
                    child: Text(
                      "ADD",
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      'CLEAR',
                    ),
                    onPressed: () {
                      clearUsers();
                    },
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: players.isNotEmpty ? players.length : 0,
                itemBuilder: (context, i) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        players[i],
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Checkbox(
                    value: isTexas,
                    onChanged: (bool x) {
                      setState(
                        () {
                          isTexas = x;
                          isTexas == true ? isOmaha = false : null;
                        },
                      );
                    },
                  ),
                  Text(
                    "Texas",
                  ),
                  SizedBox(
                    width: 70,
                  ),
                  Checkbox(
                    value: isOmaha,
                    onChanged: (bool x) {
                      setState(
                        () {
                          isOmaha = x;
                          isOmaha == true ? isTexas = false : null;
                        },
                      );
                    },
                  ),
                  Text(
                    "Omaha",
                  ),
                ],
              ),
              RaisedButton(
                child: Text(
                  "PLAY",
                ),
                onPressed: totalPlayers != 0
                    ? () async {
                        data = await getData(
                            'http://sgiix.pythonanywhere.com/api?Query=' +
                                (isTexas
                                        ? 2 * players.length + 5
                                        : 4 * players.length + 5)
                                    .toString());
                        var decoded = jsonDecode(data);
                        setState(
                          () {
                            cardCode = decoded['Query'];
                            totalPlayers = players.length;
                          },
                        );
                        uploadCardCode();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => MasterGame(
                              cardCode,
                              totalPlayers,
                              isTexas,
                            ),
                          ),
                        );
                      }
                    : null,
              ),
            ],
          ),
        );
      },
      stream: Firestore.instance.collection("player").snapshots(),
    );
  }
}
