import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provider for managing authentication state
/// Persists login state using SharedPreferences
class AuthProvider extends ChangeNotifier {
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userIdKey = 'user_id';
  static const String _emailKey = 'user_email';
  static const String _passwordKey = 'user_password';

  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _userId;
  String? _email;

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get userId => _userId;
  String? get email => _email;

  AuthProvider() {
    loadLoginState();
  }

  /// Loads the login state from SharedPreferences on initialization
  Future<void> loadLoginState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
      _userId = prefs.getString(_userIdKey);
      _email = prefs.getString(_emailKey);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading login state: $e');
      _isLoggedIn = false;
      _userId = null;
      _email = null;
    }
  }

  /// Logs in the user and persists the state
  /// [email] is the user's email or phone number
  /// [password] is the user's password
  /// [userId] is optional and can be used to identify the logged-in user
  Future<void> login({
    required String email,
    required String password,
    String? userId,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setString(_emailKey, email);
      await prefs.setString(_passwordKey, password);

      if (userId != null) {
        await prefs.setString(_userIdKey, userId);
        _userId = userId;
      } else {
        // Generate userId from email if not provided
        final generatedUserId = 'user_${email.hashCode}';
        await prefs.setString(_userIdKey, generatedUserId);
        _userId = generatedUserId;
      }

      _email = email;
      _isLoggedIn = true;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      debugPrint('Error during login: $e');
      rethrow;
    }
  }

  /// Handles login with email and password
  /// Returns true if login is successful, false otherwise
  Future<bool> handleLogin({
    required String email,
    required String password,
  }) async {
    try {
      await login(email: email, password: password);
      return true;
    } catch (e) {
      debugPrint('Login handler error: $e');
      return false;
    }
  }

  /// Logs out the user and clears persisted state
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_isLoggedInKey);
      await prefs.remove(_userIdKey);
      await prefs.remove(_emailKey);
      await prefs.remove(_passwordKey);
      _isLoggedIn = false;
      _userId = null;
      _email = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Error during logout: $e');
      rethrow;
    }
  }
}
