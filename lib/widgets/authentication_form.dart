import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/authentication.dart';

enum AuthenticationMode { Login, Signup }

class AuthenticationForm extends StatefulWidget {
  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final FocusNode passFocusNode = FocusNode();
  final FocusNode reEnterPassFocusNode = FocusNode();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController passController = TextEditingController();
  AuthenticationMode authenticationMode = AuthenticationMode.Login;
  String email;
  String password;
  bool isLoading = false;

  String mailValidator(String input) {
    if (input.contains('@')) return null;
    return 'Please enter a valid E-Mail.';
  }

  String passValidator(String input) {
    if (input.length >= 6) return null;
    return 'Please enter a password with minimum of 6 characters.';
  }

  String reEnterPassValidator(String input) {
    if (passController.text == input) return null;
    return 'Passwords do not match!';
  }

  void _submit() async {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();
    print(email);
    print(password);
    setState(() {
      isLoading = true;
    });
    if (authenticationMode == AuthenticationMode.Signup) {
      //signup
      await Provider.of<Authentication>(context, listen: false)
          .signup(email, password);
    } else {
      //login
      await Provider.of<Authentication>(context, listen: false)
          .signIn(email, password);
    }
    setState(() {
      isLoading = false;
    });
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
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(passFocusNode);
                  email = value;
                },
                onSaved: (value) => email = value,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                focusNode: passFocusNode,
                validator: passValidator,
                decoration: InputDecoration(labelText: 'Password'),
                controller: passController,
                onFieldSubmitted: (value) {
                  if (authenticationMode == AuthenticationMode.Signup)
                    FocusScope.of(context).requestFocus(reEnterPassFocusNode);
                  password = passController.text;
                },
                onSaved: (_) => password = passController.text,
              ),
              if (authenticationMode == AuthenticationMode.Signup)
                TextFormField(
                  focusNode: reEnterPassFocusNode,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  validator: reEnterPassValidator,
                  decoration: InputDecoration(labelText: 'Repeat Password'),
                  onFieldSubmitted: (_) => _submit(),
                ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? CircularProgressIndicator()
                  : RaisedButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
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
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Text(
                    '${authenticationMode == AuthenticationMode.Login ? 'SIGN UP' : 'LOGIN'} INSTEAD',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ))
            ],
          ),
        ));
  }
}
