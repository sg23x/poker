import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../api.dart';
import 'dart:convert';

class MasterGame extends StatefulWidget {
  @override
  String cardCode;
  int players;
  bool isTexas;
  MasterGame(String cardCode, int players, bool isTexas) {
    this.cardCode = cardCode;
    this.players = players;
    this.isTexas = isTexas;
  }
  _MasterGameState createState() =>
      _MasterGameState(cardCode, players, isTexas);
}

class _MasterGameState extends State<MasterGame> {
  @override
  String data;
  int players;
  String cardCode;

  bool isTexas;
  String tableCardCode;
  bool isFlop = true;
  bool isTurn = false;
  bool isRiver = false;
  bool isRefresh = false;
  String whichCard = "FLOP";
  List tableCards = [];
  _MasterGameState(String cardCode, int players, bool isTexas) {
    this.cardCode = cardCode;
    this.players = players;
    this.isTexas = isTexas;

    tableCardCode = cardCode.substring(
      isTexas ? players * 4 : players * 8,
    );
  }

  void openFlop() {
    for (int i = 0; i < 3; i++) {
      tableCards.add(
        tableCardCode.substring(
          2 * i,
          2 * i + 2,
        ),
      );
    }
  }

  void openTurn() {
    for (int i = 3; i < 4; i++) {
      tableCards.add(
        tableCardCode.substring(
          2 * i,
          2 * i + 2,
        ),
      );
    }
  }

  void openRiver() {
    for (int i = 4; i < 5; i++) {
      tableCards.add(
        tableCardCode.substring(
          2 * i,
          2 * i + 2,
        ),
      );
    }
  }

  void clearUsers() async {
    await Firestore.instance.collection('player').getDocuments().then(
      (snapshot) {
        for (DocumentSnapshot ds in snapshot.documents) {
          ds.reference.delete();
        }
      },
    );
    await Firestore.instance.collection("cards").getDocuments().then(
      (snap) {
        for (DocumentSnapshot ds in snap.documents) {
          ds.reference.delete();
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection(
            "player",
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading",
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Playing: $players",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      "$whichCard",
                    ),
                    onPressed: () {
                      setState(
                        () {
                          if (isFlop) {
                            openFlop();
                            setState(
                              () {
                                isFlop = false;
                                isTurn = true;
                                whichCard = "TURN";
                              },
                            );
                          } else if (isTurn) {
                            openTurn();
                            setState(
                              () {
                                isTurn = false;
                                isRiver = true;
                                whichCard = "RIVER";
                              },
                            );
                          } else if (isRiver) {
                            openRiver();
                            setState(
                              () {
                                isRiver = false;
                                isRefresh = true;
                                whichCard = "DONE";
                              },
                            );
                          } else if (isRefresh) {
                            setState(
                              () {
                                isFlop = true;
                                isRefresh = false;
                                whichCard = "FLOP";
                                tableCards.clear();
                              },
                            );

                            Navigator.pop(context);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
              tableCards.length != 0
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.1,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, i) {
                        String a = tableCards[i];
                        return Container(
                          child: Image.asset(
                            "assets/$a\.png",
                          ),
                        );
                      },
                      shrinkWrap: true,
                      itemCount: tableCards.length,
                    )
                  : Column(
                      children: <Widget>[
                        SizedBox(
                          height: 100,
                        ),
                        isTexas
                            ? Text("Texas Hold'em")
                            : Text(
                                "Omaha Hold'em",
                              ),
                      ],
                    )
            ],
          ),
        );
      },
    );
  }
}
