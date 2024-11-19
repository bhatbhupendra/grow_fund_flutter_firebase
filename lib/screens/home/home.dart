import 'package:grow_fund/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 235, 235, 235),
        appBar: AppBar(
          title: const Text(
            'Grow Funds',
            style: TextStyle(
              color: Colors.white, // Set the text color to white
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 79, 169, 65),
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: const Text('Logout',
                  style: TextStyle(
                    color: Colors.white, // Set the text color to white
                  )),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
