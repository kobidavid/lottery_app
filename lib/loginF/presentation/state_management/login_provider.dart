import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';
import 'package:lottery_app/loginF/core/failures.dart';
import 'package:lottery_app/loginF/core/flash_alert.dart';
import 'package:lottery_app/loginF/core/verify_auth_phone_number.dart';
import 'package:lottery_app/loginF/data/repositories_imp/db_queries_imp.dart';
import 'package:lottery_app/loginF/domain/repositories/db_queries_interface.dart';
import 'package:lottery_app/loginF/presentation/pages/register_page.dart';
import 'package:lottery_app/loginF/presentation/pages/verification_code_page.dart';
import 'package:lottery_app/presentation/pages/payment_page.dart';

import '../../../main.dart';

class LoginProvider with ChangeNotifier {
  //FirebaseAuth _auth = FirebaseAuth.instance;

  static String _aaa = "";
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn googleSignIn;
  final UserEntity currentLoggedInUser;

  final GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();
  DBQueriesImp dbQueriesImp = DBQueriesImp();

  String get userEmail => _aaa;

  LoginProvider()
      : _auth = FirebaseAuth.instance,
        _firestore = FirebaseFirestore.instance,
        googleSignIn = GoogleSignIn(),
        currentLoggedInUser = getIt();

  /* bool checkIfUserIsLogin() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        return false;
      }
    });
    return true;
  }*/

  void logOutUser() {
    _auth.signOut();
    googleSignIn.signOut();
    //firebaseAuth.currentUser;
    print('logout');
    uNameForIcon="";
    notifyListeners();
  }

  Future<Either<UserEntity, LoginFailure>> _signInWithGoogle(context) async {
    //await Firebase.initializeApp();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential authResult;
    User user;
    if (_auth.currentUser == null || googleSignIn.currentUser == null) {
      DBQueriesImp dbQueriesImp = DBQueriesImp();
      if (await dbQueriesImp.checkIfEmailExistInFireStore(
              context, googleSignInAccount.email.toString()) ==
          true) {
        authResult = await _auth.signInWithCredential(credential);
        user = authResult.user;
        userNameForIcon();
        return Left(currentLoggedInUser);
      } else {
        print("email_does_not_exist");
        showFlushbar1(context, text: "כתובת המייל לא מוכרת במערכת");
        _auth.signOut();
        googleSignIn.signOut();
        //user = _auth.currentUser;
        //return Right(LoginFailure());
      }
    }
    else if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      print('signInWithGoogle succeeded: $user');

      return Left(currentLoggedInUser);
    }
    //return Right(LoginFailure());
    return Right(LoginFailure());
  }

  Future signInWithGoogle(context) async {
    Either<UserEntity, LoginFailure> result = await _signInWithGoogle(context);

    result.fold(
      (UserEntity user) async {
        //await checkFirstLoginUser(context);
        navigateToDrawerPage(context);
      },
      (LoginFailure) {
        print("Login Failed");
      },
    );
  }

  void navigateToRegisterProfilePage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  void navigateToDrawerPage(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => PaymentPage()));
  }

  Future<bool> checkFirstLoginUser(context) async {
    //‏בדיקה אם המשתמש עבר תהליך הרישום
    bool result;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(_auth.currentUser.email)
        .get()
        .then((doc) {
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

  void checkUserLogin(context) async {
    //‏בדיקה ‏אם המשתמש כבר מחובר
    if (await _auth.currentUser != null) {
      // signed in
      navigateToDrawerPage(context);
    }
  }

  Future<User> getuserState() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  String uNameForIcon="";
  Future <void> userNameForIcon() async{
    //_auth.currentUser.phoneNumber==null?
    //String email=_auth.currentUser.email??"kobi";
    //String phone=_auth.currentUser.phoneNumber??"333";

    uNameForIcon=await dbQueriesImp.returnUserNameInFireStore();
    //uNameForIcon=await dbQueriesImp.returnUserNameInFireStore(_auth.currentUser.email!=null?_auth.currentUser.email:_auth.currentUser.phoneNumber!=null?_auth.currentUser.phoneNumber:"");
    //uNameForIcon=await dbQueriesImp.returnUserNameInFireStore(_auth.currentUser.phoneNumber);
    notifyListeners();
  }

  Future<void> loginUserByPhoneNum(context, String phoneNumber) async {
    bool isLoginMethod=true;
    if (fbKey.currentState.saveAndValidate()) {
      bool phoneExist =
          await dbQueriesImp.checkIfPhoneExist(context, phoneNumber);
      if (phoneExist == true) { //user phone exist so we can proceed with phone auth login
        VerifyAuthPhoneNumber verifyAuthPhoneNumber=VerifyAuthPhoneNumber();
        await verifyAuthPhoneNumber.verifyAuthPhoneNum(phoneNumber, context,isLoginMethod);}
        /* } else {
        return false;
      }*/
      } else {
        showFlushbar1(context, text: "מספר הטלפון לא קיים במערכת");
      }
    }

  int charLength = 0;
  String charValue;

  onChanged(String value) {
    charValue = value;
    charLength = value.length;

    notifyListeners();
  }
}



