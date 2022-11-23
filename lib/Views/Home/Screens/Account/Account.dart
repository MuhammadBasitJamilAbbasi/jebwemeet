import 'package:flutter/material.dart';
import 'package:jabwemeet/Views/Home/Screens/Tabbar.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: kCustomBottomNavBar(
        index: 3,
      ),
      body: Center(
        child: Text("Account"),
      ),
    );
  }
}
