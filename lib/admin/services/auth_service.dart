import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign In
  Future<UserModel?> signIn(String email, String password) async {
    try {
      if (kDebugMode) print('[AuthService] Attempting sign in for: $email');
      
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (kDebugMode) print('[AuthService] Firebase Auth successful. UID: ${userCredential.user!.uid}');

      // Update last login
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .update({'lastLogin': FieldValue.serverTimestamp()});

      if (kDebugMode) print('[AuthService] Fetching user document from Firestore');
      
      // Fetch user data
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (kDebugMode) print('[AuthService] User doc exists: ${userDoc.exists}');
      
      if (!userDoc.exists) {
        throw Exception('User data not found in Firestore');
      }
      
      final userModel = UserModel.fromFirestore(userDoc);
      if (kDebugMode) print('[AuthService] User model created: email=${userModel.email}, role=${userModel.role}');
      
      return userModel;
    } catch (e) {
      if (kDebugMode) print('[AuthService] Sign in error: $e');
      rethrow;
    }
  }

  // Sign Up (for sellers primarily)
  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
    String? gstin,
    String? brandName,
    String? warehouseAddress,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        uid: userCredential.user!.uid,
        email: email,
        fullName: fullName,
        role: role,
        isActive: role == UserRole.seller ? false : true, // Sellers need approval
        createdAt: DateTime.now(),
        gstin: gstin,
        brandName: brandName,
        warehouseAddress: warehouseAddress,
        isApproved: role == UserRole.seller ? false : null,
      );

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.toFirestore());

      return user;
    } catch (e) {
      rethrow;
    }
  }

  // Get current user data
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (kDebugMode) print('[AuthService] Getting current user data...');
      final user = _auth.currentUser;
      if (kDebugMode) print('[AuthService] Firebase Auth user: ${user?.email ?? "null"}');
      
      if (user == null) return null;

      final userDoc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();

      if (kDebugMode) print('[AuthService] Firestore doc exists: ${userDoc.exists}');
      if (!userDoc.exists) return null;

      final userModel = UserModel.fromFirestore(userDoc);
      if (kDebugMode) print('[AuthService] User role: ${userModel.role}');
      return userModel;
    } catch (e) {
      if (kDebugMode) print('[AuthService] Error: $e');
      rethrow;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Check user role for routing
  Future<UserRole?> getUserRole(String uid) async {
    try {
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (!userDoc.exists) return null;

      final userData = userDoc.data();
      final roleString = userData?['role'] as String?;
      if (roleString == null) return null;
      return UserRole.values.firstWhere(
        (role) => role.toString() == 'UserRole.$roleString',
        orElse: () => UserRole.seller,
      );
    } catch (e) {
      return null;
    }
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
