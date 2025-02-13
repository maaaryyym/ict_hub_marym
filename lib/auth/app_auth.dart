import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/data source/profile_data_source.dart';
import '../ui/screens/LoginScreen.dart';
import '../ui/screens/homeNav.dart';
import '../ui/widgets/custom_text.dart';

class AppAuth {

  static Future<void> register({
    required String mail,
    required String pass,
    required BuildContext context,
    required String name,
    required String phone,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: mail,
        password: pass,
      );

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomText(data: "User Registered Successfully"),
          backgroundColor: Colors.green));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: CustomText(data: e.code), backgroundColor: Colors.red));
    } catch (e) {
      print(e);
    }
  }

  //!======================================================================

  static Future login({required String mail,
    required String pass,}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mail,
          password: pass
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  //!======================================================================

  static Future signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    ProfileDataSource.user = null;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
  }
}
