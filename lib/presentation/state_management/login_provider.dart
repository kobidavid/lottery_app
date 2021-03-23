import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginProvider extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //String get authuser=>firebaseAuth.currentUser.email;

  static String _aaa="";
  String get userEmail =>_aaa;
  //String get user =>firebaseAuth.currentUser.email.toString();

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
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
     _aaa= googleUser.email;

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
   void userLoginUpdate(){
    print('kobkob');
    notifyListeners();
  }

}
