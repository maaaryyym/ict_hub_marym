import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data model/user_model.dart';

class ProfileDataSource {
  static UserModel? user;

  static Future<void> getUserFromFireStore() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      Map<String, dynamic>? data = doc.data();
      user = UserModel.fromMap(data!);
    } on Exception catch (e) {
      print(e);
    }
  }
}
