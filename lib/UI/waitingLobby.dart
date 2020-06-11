import 'package:flutter/material.dart';

class WaitingLobby extends StatelessWidget {
  WaitingLobby({
    @required this.gameID,
    @required this.playerName,
  });
  final String playerName;
  final String gameID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '$gameID $playerName',
        ),
      ),
    );
  }
}
