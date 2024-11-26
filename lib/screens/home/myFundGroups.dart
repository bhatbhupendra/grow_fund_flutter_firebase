import 'package:flutter/material.dart';
import 'package:grow_fund/models/fund_group.dart';
import 'package:grow_fund/screens/home/fund_group_tile.dart';
import 'package:provider/provider.dart';

class MyFundGroups extends StatefulWidget {
  const MyFundGroups({super.key});

  @override
  State<MyFundGroups> createState() => _MyFundGroupsState();
}

class _MyFundGroupsState extends State<MyFundGroups> {
  @override
  Widget build(BuildContext context) {
    //getting the my group list
    final myFundGroup = Provider.of<List<FundGroup>?>(context) ?? [];

    return Column(
      children: [
        // Other widgets above the ListView
        Text("My Fund Groups", style: TextStyle(fontSize: 20)),

        Expanded(
          // Ensures the ListView takes the remaining space
          child: ListView.builder(
            itemCount: myFundGroup.length,
            itemBuilder: (context, index) {
              return FundGroupTile(group: myFundGroup[index]);
            },
          ),
        ),
      ],
    );
  }
}
