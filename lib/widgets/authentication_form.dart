import 'package:flutter/material.dart';

class AuthenticationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
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
            decoration: InputDecoration(labelText: 'E-Mail'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: Theme.of(context).primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {},
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
