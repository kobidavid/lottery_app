import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier {

  bool checkIfUserIsLogin()  {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        return false;
      }
    });
    return true;

  }

  void logOutUser(){
    FirebaseAuth.instance.signOut();
    print('logout');
    notifyListeners();
  }
}
