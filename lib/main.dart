import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _gSignIn = GoogleSignIn();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  User currenUser;
  SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    var firesteoreDb =
        FirebaseFirestore.instance.collection("board").snapshots();
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
              _googleSignIn();
            },
          ),

          //

          FlatButton(
            child: Text("Signin With Email"),
            color: Colors.blue,
            onPressed: () {
              _signInWithEmail();
            },
          ),

          //

          FlatButton(
            child: Text("Signin Up Email"),
            color: Colors.greenAccent,
            onPressed: () {
              _signUp();
            },
          ),

          //

          FlatButton(
            child: Text("Sign Out Goolge"),
            color: Colors.greenAccent,
            onPressed: () {
              _signOutG();
            },
          ),

          //

          FlatButton(
            child: Text("Firestoore"),
            color: Colors.greenAccent,
            onPressed: () {
              _firestoreDBTest();
            },
          )
        ],
      ),
    );
  }

  void _signInWithEmail() async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(
              email: "mgmg@gmail.com", password: "mgmg123"))
          .user;
      print("Success sign in");
      print("Login User is ==>> ${user.email}");
    } catch (e) {
      print(e.message);
      print("no success sing in");
    }
  }

  void _signUp() async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: "baybay@gmail.com", password: "baybay123");
      print("Success sign Sign Up");
    } catch (e) {
      print(e.message);
      print("no success sing in");
    }
  }

  Future _googleSignIn() async {
    try {
      GoogleSignInAccount signAc = await _gSignIn.signIn();
      GoogleSignInAuthentication gAuth = await signAc.authentication;
      AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: gAuth.idToken, accessToken: gAuth.accessToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(authCredential);
      User user = userCredential.user;

      assert(user.displayName != null);
      assert(user.email != null);
      // assert(user.photoURL != null);

      print(user.email.toString());
      print(user.displayName.toString());

      User currentUser = _auth.currentUser;
      assert(currenUser.email == user.email);
      print(currentUser.email.toUpperCase());
      print("Successfully SignIn");
    } catch (e) {
      print("NOt Success Sign In");
    }
  }

  Future _signOutG() async {
    try {
      await _gSignIn.signOut();
      print("G sign out success");
    } catch (e) {
      print("G sign out not success");
    }
  }

  void _firestoreDBTest() {}
}
