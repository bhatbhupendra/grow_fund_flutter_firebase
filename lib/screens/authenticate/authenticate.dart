import 'package:grow_fund/screens/authenticate/register.dart';
import 'package:grow_fund/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Register(toggleFunc: toggleView);
    } else {
      return SignIn(toggleFunc: toggleView);
    }
  }
}
