import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Authentication {
  static Future<User> registerUsingEmailPassword(
      {String email, String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        Fluttertoast.showToast(
          msg: "The password is too weak.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepPurple.shade400,
          textColor: Colors.white,
          fontSize: 17.0,
        );
      } else if (e.code == "email-already-in-use") {
        Fluttertoast.showToast(
          msg: "Account already exists for that email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepPurple.shade400,
          textColor: Colors.white,
          fontSize: 17.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: e,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepPurple.shade400,
          textColor: Colors.white,
          fontSize: 17.0,
        );
    }
    return user;
  }

  static Future<User> signInUsingEmailPassword(
      {String email, String password, BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "No user found for that email.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepPurple.shade400,
          textColor: Colors.white,
          fontSize: 17.0,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "Wrong password.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.deepPurple.shade400,
          textColor: Colors.white,
          fontSize: 17.0,
        );
      }
    }
    return user;
  }
}
