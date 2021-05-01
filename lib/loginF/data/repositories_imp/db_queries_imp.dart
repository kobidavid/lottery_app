import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottery_app/core/di/di.dart';
import 'package:lottery_app/core/service_locator.dart';
import 'package:lottery_app/core/shared_preferences_names.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';
import 'package:lottery_app/loginF/core/flash_alert.dart';
import 'package:lottery_app/loginF/domain/repositories/db_queries_interface.dart';
import 'package:lottery_app/loginF/presentation/pages/register_page.dart';
import 'package:lottery_app/loginF/presentation/state_management/login_provider.dart';
import 'package:lottery_app/presentation/pages/payment_page.dart';
import 'package:lottery_app/presentation/pages/regular_ticket.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class DBQueriesImp extends DBQueriesInterface{
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  var currentUer = locator<UserEntity>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> checkIfUserExist(email)async{
    final snapShot = await users.doc(auth.currentUser.uid).get();

    if (snapShot == null || !snapShot.exists) {
      return false;
    }
    else{
      return true;
    }
  }

  Future<bool> checkIfEmailExist(context)async{
    final snapShot = await users.doc(auth.currentUser.email).get();

    if (snapShot == null || !snapShot.exists) {
      return false;
    }
    else{
      return true;
    }
  }



  Future<void> registerUser(context) async {
    var currentUer = locator<UserEntity>();
    print(currentUer.lastName);
    final snapShot = await users.doc(auth.currentUser.uid).get();

    if (snapShot == null || !snapShot.exists) {
      await saveOnFirestore(context);
    } else {
      showFlushbar1(context, text: "המשתמש קיים במערכת");
    }
  }

  Future<void> saveOnFirestore(context) async{
print('ddd');

    // Call the user's CollectionReference to add a new user
    users
        .doc(currentUer.email)
        .set({
      'first_name': currentUer.firstName,
      'last_name': currentUer.lastName,
      //'user_email': currentUer.email,
      'user_phone': currentUer.phone,
      'user_id': currentUer.id
    })
        .
    //then((value) => prefs.setBool(IS_LOGIN, true)).
    //then((value) => Provider.of<LoginProvider>(context,listen: false).getSPuserNameValue()).
    then((value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PaymentPage()))).
    //then((value) => _prefs.setString(USER_EMAIL, currentUser.email)).
    catchError((error) => print("Failed to add user: $error"));
  }
}

/*
  Future<void> addUser1() async {
    final snapShot = await users.doc(getIt<UserEntity>().id).get();

    if (snapShot == null || !snapShot.exists) {
      await saveOnFirestore();
    } else {
      print('ssss');
      // showFlushbar1(context);
      //print("user already registered exists in the system");
      //userAlreadyRegisterInThePast=true;
      //notifyListeners();

    }
  }

  Future <void> saveOnFirestore() {
    // Call the user's CollectionReference to add a new user
    users
        .doc(currentUser.id)
        .set({
          'full_name': currentUser.name,
          'user_email': currentUser.email,
          'user_phone': currentUser.phone
        })
        .then((value) => print(currentUser.id))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
*/
