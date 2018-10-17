import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_shop/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseUser user;
  String _email, _password;
  bool _isObscured = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseAuth.instance.currentUser().then((user) {
      if( user != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(user: user)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Form(key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
              children: <Widget>[
                SizedBox(height: kToolbarHeight,),
                buildTitle(),
                buildTitleLine(),
                SizedBox(height: 70.0,),
                buildEmailTextField(),
                SizedBox(height: 30.0,),
                buildPasswordTextField(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text("Forget password", style: TextStyle(
                    color: Colors.grey
                  ),),
                ),
                SizedBox(height: 30.0,),
                RaisedButton(
                  onPressed: signIn,
                  child: Text('Sign in'),
                )
              ],
            )
        )
    );
  }



  TextFormField buildPasswordTextField() {
    return TextFormField(
                validator: (passwordInput) {
                  if(passwordInput.isEmpty) {
                    return 'Please type a password';
                  }
                },
                onSaved: (passwordInput) => _password = passwordInput,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    color: _isObscured ? Colors.blueGrey : Colors.blue,
                  )
                ),
                obscureText: _isObscured,
              );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
                validator: (emailInput) {
                  if(emailInput.isEmpty) {
                    return 'Please type an email';
                  }
                },
                onSaved: (emailInput) => _email = emailInput,
                decoration: InputDecoration(
                    labelText: 'Email'
                ),
              );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 12.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: 38.0,
          height: 1.5,
          color: Colors.black,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child:  Text("Login", style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40.0,
      ),),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;

    if(formState.validate()) {
      //TODO login to firebase
      formState.save();

      try {
        user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        // TODO navigate to Home
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(user: user) ));
      } catch(e) {
        print(e.message);

        showDialog(context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('An Error Occured'),
              content: Text(e.message),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Ok'))
              ],
            )
        );
      }
    }
  }
}
