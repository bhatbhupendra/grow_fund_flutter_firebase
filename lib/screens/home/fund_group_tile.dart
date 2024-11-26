import 'package:flutter/material.dart';
import 'package:grow_fund/models/fund_group.dart';
import 'package:grow_fund/screens/home/fund_table.dart';
import 'package:grow_fund/screens/home/settings_form.dart';

class FundGroupTile extends StatelessWidget {
  final FundGroup? group;
  FundGroupTile({this.group});

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(fg_id: group?.fg_id),
            );
          });
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.brown[100],
                backgroundImage: AssetImage('assets/coffee_icon.png'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScrollableTable()),
                );
              },
              minLeadingWidth: 10,
              title: Text(group?.name ?? 'Unknown'),
              subtitle: Text(
                  'Fund:${group?.fund ?? '0'}, users:${group?.maxUsers ?? '0'}, %gap:${group?.perGap ?? '0'}'),
              trailing: TextButton.icon(
                icon: Icon(Icons.settings),
                label: Text(""),
                onPressed: () => _showSettingsPanel(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
