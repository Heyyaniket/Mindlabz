import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  UserRole? get userRole => _currentUser?.role;
  bool get isSeller => _currentUser?.role == UserRole.seller;
  bool get isAdmin => _currentUser?.role == UserRole.admin;
  bool get isSuperAdmin => _currentUser?.role == UserRole.superAdmin;

  // Initialize auth state
  Future<void> initializeAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      if (kDebugMode) print('[AuthProvider] Initializing auth...');
      _currentUser = await _authService.getCurrentUserData();
      if (kDebugMode) print('[AuthProvider] Current user: ${_currentUser?.email}');
    } catch (e) {
      if (kDebugMode) print('[AuthProvider] Error during init: $e');
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
      if (kDebugMode) print('[AuthProvider] Init complete. isAuthenticated: $isAuthenticated');
    }
  }

  // Sign In
  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (kDebugMode) print('[AuthProvider] Signing in with: $email');
      _currentUser = await _authService.signIn(email, password);
      if (kDebugMode) print('[AuthProvider] Sign in successful. User: ${_currentUser?.email}, Role: ${_currentUser?.role}');
      _isLoading = false;
      notifyListeners();
      if (kDebugMode) print('[AuthProvider] isAuthenticated: $isAuthenticated');
      return true;
    } catch (e) {
      if (kDebugMode) print('[AuthProvider] Sign in error: $e');
      _errorMessage = _getErrorMessage(e.toString());
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Sign Up (for sellers)
  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
    required UserRole role,
    String? gstin,
    String? brandName,
    String? warehouseAddress,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _authService.signUp(
        email: email,
        password: password,
        fullName: fullName,
        role: role,
        gstin: gstin,
        brandName: brandName,
        warehouseAddress: warehouseAddress,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = _getErrorMessage(e.toString());
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.signOut();
      _currentUser = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Reset Password
  Future<bool> resetPassword(String email) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.resetPassword(email);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = _getErrorMessage(e.toString());
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Helper to get user-friendly error messages
  String _getErrorMessage(String error) {
    if (error.contains('user-not-found')) {
      return 'No user found with this email';
    } else if (error.contains('wrong-password')) {
      return 'Incorrect password';
    } else if (error.contains('email-already-in-use')) {
      return 'Email is already registered';
    } else if (error.contains('weak-password')) {
      return 'Password is too weak';
    } else if (error.contains('invalid-email')) {
      return 'Invalid email address';
    } else if (error.contains('network-request-failed')) {
      return 'Network error. Please check your connection';
    }
    return 'An error occurred. Please try again';
  }
}
