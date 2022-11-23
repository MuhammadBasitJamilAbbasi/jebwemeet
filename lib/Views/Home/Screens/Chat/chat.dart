import 'package:flutter/material.dart';
import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: kCustomBottomNavBar(
        index: 2,
      ),
      body: Center(
        child: Text("Chat"),
      ),
    );
  }
}
