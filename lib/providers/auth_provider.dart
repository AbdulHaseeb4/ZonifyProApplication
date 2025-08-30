import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// 🔹 User Model for app (extendable)
class AppUser {
  final String uid;
  final String email;
  final String role;
  final String? name;
  final String? profileImage;

  AppUser({
    required this.uid,
    required this.email,
    required this.role,
    this.name,
    this.profileImage,
  });

  factory AppUser.fromMap(String uid, Map<String, dynamic> data) {
    return AppUser(
      uid: uid,
      email: data['email'] ?? '',
      role: data['role'] ?? 'guest',
      name: data['name'],
      profileImage: data['profileImage'],
    );
  }
}

/// 🔹 Firebase auth state (User? stream)
final authStateProvider = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);

/// 🔹 Firestore user data provider (fetch full user profile)
final appUserProvider = FutureProvider<AppUser?>((ref) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return null;

  final doc = await FirebaseFirestore.instance
      .collection("users")
      .doc(user.uid)
      .get();

  if (doc.exists) {
    return AppUser.fromMap(user.uid, doc.data()!);
  }
  return null;
});

/// 🔹 Role shortcut provider
final roleProvider = Provider<String?>((ref) {
  final appUser = ref.watch(appUserProvider).value;
  return appUser?.role;
});

/// 🔹 Login action
final loginProvider = Provider((ref) {
  return (String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? "Login failed");
    }
  };
});

/// 🔹 Logout action
final logoutProvider = Provider((ref) {
  return () async {
    await FirebaseAuth.instance.signOut();
  };
});
