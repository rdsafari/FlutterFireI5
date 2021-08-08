import 'package:ccw/services/auth.dart';
import 'package:ccw/shared/constant.dart';
import 'package:ccw/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({this.toggle});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authenticate = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String pass = '';
  String err = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.black45,
                elevation: 0.0,
                title: Text('Sign in CCW'),
                actions: [
                  FlatButton.icon(
                      onPressed: () {
                        widget.toggle();
                      },
                      icon: Icon(Icons.account_box),
                      label: Text('Register')),
                ]),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: textBoxDecor.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                        decoration: textBoxDecor.copyWith(hintText: 'Password'),
                        validator: (val) =>
                            val.length < 6 ? 'Password to short' : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => pass = val);
                        }),
                    SizedBox(height: 20),
                    RaisedButton(
                      color: Colors.blueGrey[700],
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result =
                              await _authenticate.signInToFirebase(email, pass);
                          if (result == null) {
                            setState(() {
                              err = 'Error Login';
                              loading = false;
                            });
                          } else {}
                        }
                      },
                    ),
                    SizedBox(height: 12),
                    Text(
                      err,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
