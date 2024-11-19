import 'package:grow_fund/models/user.dart';
import 'package:grow_fund/screens/authenticate/authenticate.dart';
import 'package:grow_fund/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user);
    //return either home or Authenticat wigit
    // return Home();
    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
