import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;

final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("users");

void main() {
  runApp(new MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final GlobalKey<FormState> _globalKey =

  User currenUser;
  SharedPreferences preferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Board"),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
      ),

      //
      body: Column(
        children: [
          FlatButton(
            child: Text("Signin Google"),
            color: Colors.orange,
            onPressed: () {
              _signinGoogle();
            },
          ),

          //

          FlatButton(
            child: Text("Signin With Email"),
            color: Colors.blue,
            onPressed: () {},
          ),

//

          FlatButton(
            child: Text("Signin Up"),
            color: Colors.greenAccent,
            onPressed: () {},
          )
        ],
      ),
    );
  }

  Future<User> _signinGoogle() async {
    preferences = await SharedPreferences.getInstance();
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication authentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken);

    User fbUser = (await firebaseAuth.signInWithCredential(credential)).user;

    if (fbUser != null) {
      print("User id is ===>> ${fbUser.uid}");
      print("User id is ===>> ${fbUser.displayName}");
    }

    return fbUser;
  }
}
