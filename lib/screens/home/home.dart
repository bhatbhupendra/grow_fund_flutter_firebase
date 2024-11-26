import 'package:grow_fund/models/fund_group.dart';
import 'package:grow_fund/models/user.dart';
import 'package:grow_fund/screens/home/fund_table.dart';
import 'package:grow_fund/screens/home/myFundGroups.dart';
import 'package:grow_fund/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:grow_fund/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return StreamProvider<List<FundGroup>>.value(
      initialData: [],
      value: DatabaseService(uid: user!.uid).getManagerGroup,
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
                Icons.add,
                color: Colors.white,
              ),
              label: const Text('',
                  style: TextStyle(
                    color: Colors.white,
                    // Set the text color to white
                  )),
              onPressed: () async {
                await DatabaseService(uid: user!.uid)
                    .createFundGroup(50000, 10, 2);
              },
            ),
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
        body: Column(
          children: [
            const SizedBox(height: 20.00),
            Expanded(
              // Ensures MyFundGroups takes the remaining space
              child: Container(
                child: const MyFundGroups(), // Ensures proper layout
              ),
            ),
          ],
        ),
      ),
    );
  }
}
