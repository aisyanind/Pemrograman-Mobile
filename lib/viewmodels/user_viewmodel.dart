import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../models/user.dart';

class UserViewModel extends ChangeNotifier {
  final dbHelper = DatabaseHelper();

  Future<void> registerUser(User user) async {
    await dbHelper.saveUser(user);
    notifyListeners();
  }

  Future<bool> loginUser(String username, String password) async {
    final user = await dbHelper.getUser(username);
    if (user == null || user.password != password) return false;

    // Save login state to SQLite
    await dbHelper.saveLoginStatus(true);
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    await dbHelper.clearLoginStatus();  // Clear the login state from SQLite
    notifyListeners();
  }

  Future<bool> checkLoginStatus() async {
    return await dbHelper.getLoginStatus();
  }
}
