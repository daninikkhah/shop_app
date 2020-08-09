import 'package:flutter/material.dart';

enum AuthenticationMode { Login, Signup }

class AuthenticationForm extends StatefulWidget {
  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final FocusNode passFocusNode = FocusNode();
  final FocusNode reEnterPassFocusNode = FocusNode();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  AuthenticationMode authenticationMode = AuthenticationMode.Login;

  String mailValidator(String input) {
    if (input.contains('@')) return null;
    return 'Please enter a valid E-Mail.';
  }

  String passValidator(String input) {
    if (input.length >= 6) return null;
    return 'Please enter a password with minimum of 6 characters.';
  }

  void _submit() {
    _form.currentState.validate();
  }

  void switchAuthenticationMode() {
    setState(() {
      authenticationMode = authenticationMode == AuthenticationMode.Signup
          ? AuthenticationMode.Login
          : AuthenticationMode.Signup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _form,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                validator: mailValidator,
                decoration: InputDecoration(labelText: 'E-Mail'),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(passFocusNode);
                },
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                focusNode: passFocusNode,
                validator: passValidator, //todo see if it will work this way
                decoration: InputDecoration(labelText: 'Password'),
                onFieldSubmitted: (value) {
                  if (authenticationMode == AuthenticationMode.Signup)
                    FocusScope.of(context).requestFocus(reEnterPassFocusNode);
                },
              ),
              if (authenticationMode == AuthenticationMode.Signup)
                TextFormField(
                  focusNode: reEnterPassFocusNode,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(labelText: 'Repeat Password'),
                  onFieldSubmitted: (_) => _submit,
                ),
              const SizedBox(
                height: 20,
              ),
              RaisedButton(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: _submit,
                child: Text(
                  authenticationMode == AuthenticationMode.Login
                      ? 'LOGIN'
                      : 'SING UP',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                  onPressed: switchAuthenticationMode,
                  child: Text(
                    '${authenticationMode == AuthenticationMode.Login ? 'SIGN UP' : 'LOGIN'} INSTEAD',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ))
            ],
          ),
        ));
  }
}
