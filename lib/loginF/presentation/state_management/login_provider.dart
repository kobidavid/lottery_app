import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottery_app/core/shared_preferences_names.dart';
import 'package:lottery_app/domain/entities/spEntity.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static String _aaa = "";

  String get userEmail => _aaa;

  bool checkIfUserIsLogin() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        return false;
      }
    });
    return true;
  }

  void logOutUser() {
    firebaseAuth.signOut();
    //firebaseAuth.currentUser;
    print('logout');
    notifyListeners();
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    _aaa = googleUser.email;

    /*SharedPreferences prefs =
    await SharedPreferences.getInstance();
    if (prefs.getString(USER_EMAIL)==_aaa){
      print('valid email:'+ prefs.getString(USER_EMAIL));
    }*/
    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    notifyListeners();

    // Once signed in, return the UserCredential

    firebaseAuth.signInWithCredential(credential);

    notifyListeners();
  }

  void userLoginUpdate() {
    print('kobkob');
    notifyListeners();
  }

    String _spName="";
    bool _spLogin=false;

  String get spName => _spName;
  bool get spLogin => _spLogin;

   Future<void> getSPuserNameValue()  async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.setBool(IS_LOGIN, true);
    if (prefs.getBool(IS_LOGIN) == true) {
      ////final myName= prefs.getString(USER_NAME);
      _spName = prefs.getString(USER_NAME);
      _spLogin = prefs.getBool(IS_LOGIN);
      notifyListeners();

    }
  }

  Future<void> spLogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(IS_LOGIN, false);
    _spLogin = prefs.getBool(IS_LOGIN);
    notifyListeners();
  }

  Future<void> init() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _spName= prefs.getString(USER_NAME);
    _spLogin= prefs.getBool(IS_LOGIN);
  }

  /*Future<void> logOutSPuserNameValue() async {
    spName = "";
    notifyListeners();
  }*/
}
