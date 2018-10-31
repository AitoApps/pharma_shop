import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Client {
  String clientID;
  String email;
  String name;
  String image;
  bool isAdmin;

  Client({this.email, this.name, this.image, this.isAdmin});

  Client.fromMap(Map<String, dynamic> data)
    : this(email: data['email'], name: data['name'], image: data['user_image'], isAdmin: data['is_admin']);

  toMap() => {
    'email': this.email,
    'name': this.name,
    'user_image': this.image,
    'is_admin': this.isAdmin
  };

  Client.fromSnapshot(DocumentSnapshot snapshot)
    : clientID = snapshot.documentID,
      email = snapshot['email'],
      name = snapshot['name'],
      image = snapshot['user_image'],
      isAdmin = snapshot['is_admin'];
}