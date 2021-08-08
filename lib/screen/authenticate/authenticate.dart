import 'package:ccw/screen/authenticate/regis.dart';
import 'package:ccw/screen/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'regis.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggle: toggleView);
    } else {
      return Register(toggle: toggleView);
    }
  }
}
