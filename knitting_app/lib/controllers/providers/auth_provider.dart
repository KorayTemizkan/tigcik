// Burası mantıksal bölüm, burada UI olmaz.
// UI kısımlarını kullanmamakla birlikte önceki Firebase projemin kodlarını kullandım
// Diğer her şey aynı yani

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProviderFirebase extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? _user;
  User? get user => _user;

  String? get email => user?.email;
  String? get uid => user?.uid;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  AuthProviderFirebase() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> register({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _db.collection('users').doc(credential.user!.uid).set({
        'email': email,
        'displayName': '', // username yerine böyle kullan sektör standardı
        'photoUrl': '',
        'likedProducts': [],
        'favoriteProducts': [],
        'createdAt': FieldValue.serverTimestamp(),
      });

      return true;
    } on FirebaseException catch (e) {
      print(e.code);
      return false;
    }
  }

  Future<bool> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _isLoggedIn = true;
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    await _user?.reauthenticateWithCredential(credential);
    await _user?.delete();
  }

  Future<void> changePassword(String newPassword) async {
    await _user?.updatePassword(newPassword);
  }

  Future<void> syncToCloud() async {
    await _db.collection("users").doc(uid).set({
      //"favourites": favourites,
      "updatedAt": FieldValue.serverTimestamp(),
    });
  }
}
