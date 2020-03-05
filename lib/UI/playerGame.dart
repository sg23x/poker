import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerGame extends StatelessWidget {
  @override
  String username;
  int label;
  String cardCode;
  String playerCardCode;
  bool isTexas;
  List playerCards = [];
  // String playerCardCode;
  PlayerGame(String username) {
    this.username = username;
    getLabel();
  }

  void getLabel() async {
    await Firestore.instance.collection("player").getDocuments().then(
      (snap) {
        snap.documents.forEach(
          (f) {
            if (f.data['username'] == username) {
              label = f.data['label'];
            }
          },
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("cards").snapshots(),
      builder: (context, snapshot) {
        void getPlayerCardCode() {
          playerCards.clear();
          cardCode = snapshot.data.documents[0]['cardCode'];
          isTexas = snapshot.data.documents[0]['isTexas'];
          playerCardCode = isTexas
              ? cardCode.substring(
                  label * 4,
                  label * 4 + 4,
                )
              : cardCode.substring(
                  label * 8,
                  label * 8 + 8,
                );
          int n;
          isTexas ? n = 2 : n = 4;
          for (int i = 0; i < n; i++) {
            playerCards.add(
              playerCardCode.substring(2 * i, 2 * i + 2),
            );
          }
        }

        getPlayerCardCode();

        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Text(
                "Waits",
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "$username",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 40,
                ),
                itemBuilder: (context, i) {
                  String a = playerCards[i];
                  return Container(
                    child: Image.asset(
                      "assets/$a\.png",
                      scale: 1,
                    ),
                  );
                },
                itemCount: playerCards.length,
              ),
            ],
          ),
        );
      },
    );
  }
}
