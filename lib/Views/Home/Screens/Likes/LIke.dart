import 'package:flutter/material.dart';
import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';

class Like extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: kCustomBottomNavBar(
        index: 1,
      ),
      body: Center(
        child: Text("Like"),
      ),
    );
  }
}
