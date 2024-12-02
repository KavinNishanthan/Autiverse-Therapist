import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String centername,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          phone.isNotEmpty ||
          centername.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.uid);
        await _firestore.collection("users").doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'name': name,
          'center name': centername,
          'email': email,
          'phone': phone,
          'studentId': [],
        });
        res = "success";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
