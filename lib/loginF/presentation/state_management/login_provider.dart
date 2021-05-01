
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottery_app/core/shared_preferences_names.dart';
import 'package:lottery_app/domain/entities/spEntity.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';
import 'package:lottery_app/loginF/core/failures.dart';
import 'package:lottery_app/loginF/data/repositories_imp/db_queries_imp.dart';
import 'package:lottery_app/loginF/presentation/pages/register_page.dart';
import 'package:lottery_app/presentation/pages/payment_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class LoginProvider with ChangeNotifier {
  //FirebaseAuth _auth = FirebaseAuth.instance;
  DBQueriesImp dbQueriesImp = DBQueriesImp();
  static String _aaa = "";
  final FirebaseAuth _auth;
  final GoogleSignIn googleSignIn;
  final UserEntity currentLoggedInUser;

  String get userEmail => _aaa;


  LoginProvider()
      : _auth = FirebaseAuth.instance,
        googleSignIn = GoogleSignIn(),
        currentLoggedInUser = getIt();
  bool checkIfUserIsLogin() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        return false;
      }
    });
    return true;
  }

  void logOutUser() {
    _auth.signOut();
    //firebaseAuth.currentUser;
    print('logout');
    notifyListeners();
  }

  Future<Either<UserEntity, LoginFailure>> _signInWithGoogle() async {
    await Firebase.initializeApp();
print('ddd');
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential authResult;
    User user;
    if (_auth.currentUser == null) {
      authResult = await _auth.signInWithCredential(credential);
      user = authResult.user;
    } else {
      user = _auth.currentUser;
    }
    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      print('signInWithGoogle succeeded: $user');

      return Left(currentLoggedInUser);
    }
    return Right(LoginFailure());
  }
  Future signInWithGoogle(context) async {
    Either<UserEntity, LoginFailure> result = await _signInWithGoogle();

    result.fold(
          (UserEntity user) async{
        await checkFirstLoginUser(context);
      },
          (LoginFailure) {
        print("Login Failed");
      },
    );
  }
  void navigateToRegisterProfilePage(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegisterPage()));
  }
  void navigateToDrawerPage(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PaymentPage()));
  }

  Future<bool> checkFirstLoginUser(context) async {//‏בדיקה אם המשתמש עבר תהליך הרישום
    bool result;
    await FirebaseFirestore.instance.collection("users").doc(_auth.currentUser.email).get().then((doc) {
      if (doc.exists) {
        navigateToDrawerPage(context);
        result = false;
      } else {
        navigateToRegisterProfilePage(context);
        result = true;
      }
    });
    return result;
  }

  void checkUserLogin(context) async {//‏בדיקה ‏אם המשתמש כבר מחובר
    if (await _auth.currentUser != null) {
      // signed in
      navigateToDrawerPage(context);
    }
  }

}
