import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
import 'package:poker/UI/waitingLobby.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerLandingPage extends StatefulWidget {
  @override
  _PlayerLandingPageState createState() => _PlayerLandingPageState();
}

class _PlayerLandingPageState extends State<PlayerLandingPage> {
  String playerName;
  bool isButtonEnabled;
  Alignment align;

  FocusNode focus;
  String gameID;

  @override
  void initState() {
    isButtonEnabled = false;
    align = Alignment.lerp(
      Alignment.center,
      Alignment.centerLeft,
      2,
    );
    focus = new FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void submitName() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 150,
              child: Column(
                children: [
                  PinEntryTextField(
                    fields: 4,
                    onSubmit: (String pin) {
                      setState(
                        () {
                          gameID = pin;
                        },
                      );
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => WaitingLobby(
                            gameID: gameID,
                            playerName: playerName,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Go',
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    // showDialog(

    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         CircularProgressIndicator(
    //           backgroundColor: Colors.pink,
    //           strokeWidth: 8,
    //         ),
    //       ],
    //     );
    //   },
    // );

    // final snap = await Firestore.instance
    //     .collection('roomDetails')
    //     .document(gameID)
    //     .get();

    //   if (snap.exists) {
    //     if (snap.data['isGameStarted'] == false) {
    //       Navigator.of(context).pop();

    //       Firestore.instance
    //           .collection('roomDetails')
    //           .document(gameID)
    //           .collection('users')
    //           .document(
    //             playerID,
    //           )
    //           .setData(
    //         {
    //           'name': widget.playerName,
    //           'userID': playerID,
    //           'score': 0,
    //           'timestamp': Timestamp.now().millisecondsSinceEpoch.toString(),
    //           'isReady': false,
    //           'hasSelected': false,
    //           'selection': '',
    //           'hasSubmitted': false,
    //           'response': '',
    //         },
    //       );

    //       Navigator.of(context).pop();

    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (BuildContext context) =>WaitingLobby(),
    //         ),
    //       );
    //     } else {
    //       Navigator.of(context).pop();
    //       showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return AlertDialog(
    //             contentTextStyle: TextStyle(
    //               fontFamily: 'Indie-Flower',
    //               color: Colors.black,
    //               fontWeight: FontWeight.bold,
    //               fontSize: MediaQuery.of(context).size.height * 0.025,
    //             ),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(
    //                 12,
    //               ),
    //             ),
    //             actions: <Widget>[
    //               FlatButton(
    //                 onPressed: () {
    //                   Navigator.pop(context);
    //                 },
    //                 child: Text(
    //                   "OK",
    //                   style: TextStyle(
    //                     fontFamily: 'Indie-Flower',
    //                     color: Colors.pink,
    //                     fontWeight: FontWeight.w900,
    //                     fontSize: MediaQuery.of(context).size.height * 0.03,
    //                   ),
    //                 ),
    //               )
    //             ],
    //             content: Text(
    //               "Sorry, The game has started!",
    //             ),
    //           );
    //         },
    //       );
    //     }
    //   } else {
    //     Navigator.of(context).pop();
    //     showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return AlertDialog(
    //           contentTextStyle: TextStyle(
    //             fontFamily: 'Indie-Flower',
    //             color: Colors.black,
    //             fontWeight: FontWeight.bold,
    //             fontSize: MediaQuery.of(context).size.height * 0.025,
    //           ),
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(
    //               12,
    //             ),
    //           ),
    //           actions: <Widget>[
    //             FlatButton(
    //               onPressed: () {
    //                 Navigator.pop(context);
    //               },
    //               child: Text(
    //                 "OK",
    //                 style: TextStyle(
    //                   fontFamily: 'Indie-Flower',
    //                   color: Colors.pink,
    //                   fontWeight: FontWeight.w900,
    //                   fontSize: MediaQuery.of(context).size.height * 0.03,
    //                 ),
    //               ),
    //             )
    //           ],
    //           content: Text(
    //             "Sorry, No such game found!",
    //           ),
    //         );
    //       },
    //     );
    //   }
    // }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue,
              Colors.cyan,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(),
            Text(
              'Welcome!',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: MediaQuery.of(context).size.height * 0.1,
                color: focus.hasFocus ? Colors.yellow : Colors.black,
                fontFamily: 'Indie-Flower',
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Theme(
                          data: ThemeData(
                            primaryColor: Colors.yellow,
                            cursorColor: Colors.yellow,
                          ),
                          child: TextField(
                            focusNode: focus,
                            maxLength: 15,
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Indie-Flower',
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.04,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.tag_faces,
                              ),
                              counterText: '',
                              labelText: 'Who are you?',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.027,
                                fontFamily: 'Indie-Flower',
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                            ),
                            onChanged: (val) {
                              playerName = val;
                              if (!(playerName == null ||
                                  playerName.length == 0)) {
                                setState(
                                  () {
                                    isButtonEnabled = true;
                                    align = Alignment.center;
                                  },
                                );
                              } else {
                                setState(
                                  () {
                                    isButtonEnabled = false;
                                    align = Alignment.lerp(
                                      Alignment.center,
                                      Alignment.centerLeft,
                                      2,
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  AnimatedAlign(
                    onEnd: align ==
                            Alignment.lerp(
                              Alignment.center,
                              Alignment.centerRight,
                              2,
                            )
                        ? submitName
                        : null,
                    curve: Curves.fastOutSlowIn,
                    alignment: align,
                    duration: Duration(
                      milliseconds: 250,
                    ),
                    child: FlatButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: isButtonEnabled
                          ? () {
                              setState(
                                () {
                                  align = Alignment.lerp(
                                    Alignment.center,
                                    Alignment.centerRight,
                                    2,
                                  );
                                },
                              );
                            }
                          : null,
                      child: Icon(
                        Icons.arrow_forward,
                        size: MediaQuery.of(context).size.height * 0.14,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(),
            SizedBox(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
