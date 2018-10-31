import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class PersonData {
  String name = '';
  String phoneNumber = '';
  String email = '';
  String password = '';
}

class UserAuth {
  String statusMsg = "Account Created Successfully";

  // Create new user
  Future<FirebaseUser> createUser(PersonData userData) async {
    return _auth.createUserWithEmailAndPassword(
        email: userData.email,
        password: userData.password
    );
  }

  //Sign in user
  Future<FirebaseUser> signInUser(PersonData userData) async {
    return _auth.signInWithEmailAndPassword(
        email: userData.email,
        password: userData.password
    );
  }

  // sign in with google
  Future<FirebaseUser> signInWithGoogle() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken
    );

    return user;
  }

  //Sign out user
  Future<bool> signOut() async{
    await _auth.signOut();
     return true;
  }

  Future<bool> isLoggedIn() async {
    return  _auth.currentUser() != null;
  }

  Future<FirebaseUser> currentUser() async {
    return await _auth.currentUser();
  }

  Future<bool> isAdmin(FirebaseUser user) async {

    DocumentSnapshot userSnapshot = await Firestore.instance.collection('users').document(user.uid).get();

    Map<String, dynamic> userData = userSnapshot.data;

    return userData["is_admin"];
  }


}
