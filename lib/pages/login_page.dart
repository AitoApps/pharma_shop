import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharma_shop/pages/home_page.dart';

import 'package:pharma_shop/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  PersonData person = new PersonData();
  bool _autovalidate = false;
  bool _isLoading = false;
  bool _isObscured = true;
  UserAuth userAuth = UserAuth();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void insertUpdateUserData(FirebaseUser user) {
    final DocumentReference userRef =
        Firestore.instance.collection("users").document(user.uid);
    userRef.get().then((userSnapshot) {
      if (userSnapshot.exists) {
        userRef.setData({"last_login_date": DateTime.now()}, merge: true);
      } else {
        userRef.setData({
          "name": user.displayName,
          "email": user.email,
          "user_image": user.photoUrl,
          "last_login_date": DateTime.now(),
          "joining_date": DateTime.now(),
          "is_admin": false
        });
      }

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => HomePage(user: user)));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userAuth.currentUser().then((user) {
      if (user != null) {
        print("user: ${user.email}");

        insertUpdateUserData(user);
      } else {
        print("user: $user");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formKey,
            autovalidate: _autovalidate,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 22.0),
              children: <Widget>[
                SizedBox(
                  height: kToolbarHeight,
                ),
                buildTitle(),
                buildTitleLine(),
                SizedBox(
                  height: 70.0,
                ),
                buildEmailTextField(),
                SizedBox(
                  height: 30.0,
                ),
                buildPasswordTextField(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forget password",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                  onPressed: (){},//_handleLoginSubmitted,
                  child: Text('Sign in'),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Center(
                    child: Text(
                  "OR",
                  style: TextStyle(fontSize: 40.0, color: Colors.amber),
                )),
                SizedBox(
                  height: 30.0,
                ),
                RaisedButton(
                  onPressed: _handleSignInGoogle,
                  child: Text("With Google"),
                )
              ],
            )));
  }

  TextFormField buildPasswordTextField() {
    return TextFormField(
      validator: (passwordInput) {
        if (passwordInput.isEmpty) {
          return 'Please type a password';
        }
      },
      onSaved: (passwordInput) => person.password = passwordInput,
      decoration: InputDecoration(
          labelText: 'Password',
          helperText: 'No more than 8 characters',
          suffixIcon: IconButton(
            icon: Icon(Icons.remove_red_eye),
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
            color: _isObscured ? Colors.blueGrey : Colors.blue,
          )),
      obscureText: _isObscured,
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      validator: (emailInput) {
        if (emailInput.isEmpty) {
          return 'Please type an email';
        }
      },
      onSaved: (emailInput) => person.email = emailInput,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: 'Email'),
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
      child: Text(
        "Login",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 40.0,
        ),
      ),
    );
  }

  void _handleSignInGoogle() {
    userAuth.signInWithGoogle().then((user) {
      print("login successfully");
      insertUpdateUserData(user);
    }).catchError((e) {
      print("error:${e.toString()}");
    });
  }

  void _handleLoginSubmitted() {
    final FormState formState = _formKey.currentState;

    if (!formState.validate()) {
      //showInSnackBar('Please fix the errors in red before submitting.');
      print('Please fix the errors in red before submitting.');
    } else {
      formState.save();

      print(person.email);
      print("password" + person.password);

      userAuth.signInUser(person).then((FirebaseUser user) {
        //showInSnackBar('Login succesfull');
        print("login successfully");
        insertUpdateUserData(user);
        // move to home page
      }).catchError((e) {
        print("error:${e.toString()}");
        //showInSnackBar(e);
      });
    }
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }
}
