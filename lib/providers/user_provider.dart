import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final userServiceProvider = Provider<UserService>((ref) => UserService());

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUser({
    required String name,
    required String email,
    required String password,
    required String gender,
    required String address,
    required String city,
    required String country,
    required String phone,
    required String bankName,
    required String accountNumber,
    required String role,
  }) async {
    // 🔹 Step 1: Create user in Firebase Auth
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // 🔹 Step 2: Store user details in Firestore
    await _db.collection("users").doc(userCredential.user!.uid).set({
      "uid": userCredential.user!.uid,
      "name": name,
      "email": email,
      "gender": gender,
      "address": address,
      "city": city,
      "country": country,
      "phone": phone,
      "bankName": bankName,
      "accountNumber": accountNumber,
      "role": role,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }
}
