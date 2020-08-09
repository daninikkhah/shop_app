import 'package:flutter/material.dart';

enum AuthenticationMode { Login, Signup }

class AuthenticationForm extends StatefulWidget {
  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final FocusNode passFocusNode = FocusNode();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

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
                validator: mailValidator, //todo see if it will work this way
                decoration: InputDecoration(labelText: 'E-Mail'),
                onFieldSubmitted: (_) {
                  //todo run validator on field submit
                  FocusScope.of(context).requestFocus(passFocusNode);
                },
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                focusNode: passFocusNode,
                validator: passValidator, //todo see if it will work this way
                decoration: InputDecoration(labelText: 'Password'),
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
                  'LOGIN',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                  onPressed: () {},
                  child: Text(
                    'SIGNUP INSTEAD',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ))
            ],
          ),
        ));
  }
}
