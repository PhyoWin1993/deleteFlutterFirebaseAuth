import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

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
            onPressed: () {},
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
              // fbAuth.signUp(
              //     email: " mr.phyo.1571993mm@gmial.com",
              //     password: "@PyAePhYoWiNpYaEpHyOwIn@");
              _signUp();
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
}
