import 'package:flutter/material.dart';
import 'package:grow_fund/models/fund_group.dart';
import 'package:grow_fund/models/user.dart';
import 'package:grow_fund/services/database.dart';
import 'package:grow_fund/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  final String? fg_id;
  SettingsForm({this.fg_id});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  String? _name;
  String? _fg_id;
  String? _fund;
  String? _max_users;
  String? _per_gap;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    return StreamBuilder<Object>(
      stream: DatabaseService(uid: user?.uid).getManagerGroup,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          var dataList = snapshot.data
              as List<FundGroup>; // Cast the data to the expected type

          try {
            // Filter the instance with a specific fg_id
            var filteredGroup = dataList.firstWhere(
              (group) => group.fg_id == widget.fg_id,
            );

            if (filteredGroup != null) {
              // Print the details of the filtered group
              print("Filtered Group:");
              print(
                  filteredGroup); // Assuming `FundGroup` has a `toString` implementation
              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Update your Fund Group settings.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: filteredGroup.name,
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _name = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: filteredGroup.fund.toString(),
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val!.isEmpty ? 'Enter valid fund' : null,
                      onChanged: (val) => setState(() => _fund = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: filteredGroup.maxUsers.toString(),
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val!.isEmpty ? 'Enter valid users' : null,
                      onChanged: (val) => setState(() => _max_users = val),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      initialValue: filteredGroup.perGap.toString(),
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Percentage'),
                      validator: (val) =>
                          val!.isEmpty ? 'Enter valid % gap' : null,
                      onChanged: (val) => setState(() => _per_gap = val),
                    ),
                    SizedBox(height: 10.0),
                    TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Colors.pink[400], // Set background color here
                        ),
                        child: const Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await DatabaseService(uid: user!.uid)
                                .updateFundGroup(
                                    _name ?? filteredGroup.name,
                                    int.tryParse(_fund ?? '') ??
                                        filteredGroup.fund,
                                    int.tryParse(_max_users ?? '') ??
                                        filteredGroup.maxUsers,
                                    int.tryParse(_per_gap ?? '') ??
                                        filteredGroup.perGap,
                                    widget.fg_id);
                            Navigator.pop(context);
                          }
                        }),
                  ],
                ),
              );
            } else {
              return Container(
                  child: Text("No group found with the given fg_id."));
            }
          } catch (e) {
            return Container(child: Text("Errrror filtering group: $e"));
          }
        } else if (snapshot.hasError) {
          return Container(child: Text("Error: ${snapshot.error}"));
        } else {
          return Container(child: Text("Loading..."));
        }
      },
    );
  }
}
