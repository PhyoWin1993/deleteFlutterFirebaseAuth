// import 'package:firebase_auth/firebase_auth.dart';

// class FbAuthentication {
//   final FirebaseAuth _auth;
//   Stream<User> get authStateChanges => _auth.authStateChanges();

//   FbAuthentication(this._auth);

//   Future signIn({String email, String password}) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       print("Sign in success");
//     } on FirebaseAuthException catch (e) {
//       print(e.message.toString());
//     }
//   }

//   Future signUp({String email, String password}) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       print("Sign up Success");
//     } on FirebaseAuthException catch (e) {
//       print(e.message.toString());
//     }
//   }
// }
