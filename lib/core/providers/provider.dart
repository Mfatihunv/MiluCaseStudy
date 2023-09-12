import 'package:casestudy/core/models/user_model.dart';
import 'package:casestudy/core/services/service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!; //! Önemli
  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetail();
    _user = user;
    notifyListeners();
  }
}
