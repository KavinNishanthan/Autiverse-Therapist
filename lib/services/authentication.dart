import 'package:autiverse/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          phone.isNotEmpty &&
          centername.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(cred.user!.uid);

        String profileImageUrl = generateProfileImageUrl(name);

        await _firestore.collection("users").doc(cred.user!.uid).set({
          'uid': cred.user!.uid,
          'name': name,
          'center name': centername,
          'email': email,
          'phone': phone,
          'profileImageUrl': profileImageUrl,
          'studentId': [],
        });
        res = "success";
      } else {
        res = "Please fill all fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  String generateProfileImageUrl(String name) {
    String initial = name.isNotEmpty ? name[0].toUpperCase() : 'A';
    String imageUrl =
        "https://ui-avatars.com/api/?name=$initial&background=random&color=fff&length=1";
    return imageUrl;
  }

  Future<Object> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      DocumentSnapshot doc = await _firestore
          .collection('user')
          .doc(userCredential.user!.uid)
          .get();

      if (doc.exists) {
        return {
          'status': 'success',
          'message': 'User logged in successfully',
          'data': doc.data() as Map<String, dynamic>,
        };
      } else {
        throw Exception('User details not found in Firestore');
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> addStudent({
    required String name,
    required int age,
    required String dob,
    required String email,
    required String parentMobile,
    required String fatherName,
    required String motherName,
    required String gender,
    required String bloodGroup,
    required BuildContext context,
  }) async {
    try {
      QuerySnapshot studentSnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('email', isEqualTo: email)
          .get();

      if (studentSnapshot.docs.isNotEmpty) {
        return "Student with this email already exists";
      }

      String profileImageUrl = generateProfileImageUrl(name);

      DocumentReference docRef =
          FirebaseFirestore.instance.collection('students').doc();
      await docRef.set({
        'studentId': docRef.id,
        'name': name,
        'age': age,
        'dob': dob,
        'email': email,
        'parentMobile': parentMobile,
        'fatherName': fatherName,
        'motherName': motherName,
        'gender': gender,
        'bloodGroup': bloodGroup,
        'profileImageUrl': profileImageUrl,
        'games': [],
        'createdAt': FieldValue.serverTimestamp(),
      });

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      String currentUserId = userProvider.user?.uid ?? '';

      if (currentUserId.isEmpty) {
        return "No logged-in user found";
      }

      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(currentUserId);

      await userRef.update({
        'studentIds': FieldValue.arrayUnion([docRef.id]),
      });

      return "Student added successfully with ID: ${docRef.id}";
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
}
