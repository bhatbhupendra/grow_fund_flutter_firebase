import 'package:grow_fund/services/auth.dart';
import 'package:grow_fund/shared/constants.dart';
import 'package:grow_fund/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function? toggleFunc;
  SignIn({this.toggleFunc});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String errors = '';

  @override
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: const Color(0xFFEBEBEB), // Soft gray background
            appBar: AppBar(
              backgroundColor: const Color(0xFF4FA941), // A richer green color
              elevation: 2.0, // Add subtle shadow
              title: const Text(
                'Sign in to Grow Funds',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              actions: <Widget>[
                ElevatedButton.icon(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Register",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6BBE77), // Softer green
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                  onPressed: () {
                    widget.toggleFunc!();
                  },
                )
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (val) => (val == null || val.isEmpty)
                          ? 'Enter an email'
                          : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey[700]),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (val) => (val == null || val.length < 6)
                          ? 'Enter a password greater than 6+ characters'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF4FA941), // Green color
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 30.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                errors =
                                    "Could not sign in with those credentials";
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Center(
                      child: Text(
                        errors,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}


// child: ElevatedButton(
//           //RaisedButton is now deprecated
//           child: const Text('sign in anon'),
//           onPressed: () async {
//             dynamic result = await _auth.signInAnon(); //it could be null or ...
//             if (result == null) {
//               print('error signing in');
//             } else {
//               print('signed in');
//               print(result.uid);
//             }
//           },
//         ),
