import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottery_app/core/di/di.dart';
import 'package:lottery_app/core/shared_preferences_names.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';
import 'package:lottery_app/loginF/core/flash_alert.dart';
import 'package:lottery_app/loginF/presentation/pages/register_page.dart';
import 'package:lottery_app/loginF/presentation/state_management/login_provider.dart';
import 'package:lottery_app/presentation/pages/payment_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class DBQueries {
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(context, UserEntity currentUser) async {
    print(currentUser.phone);
    final snapShot = await users.doc(currentUser.id).get();

    if (snapShot == null || !snapShot.exists) {
      await saveOnFirestore(context, currentUser);
    } else {
      showFlushbar1(context, text: "user already registered");
    }
  }

  Future<void> saveOnFirestore(context, UserEntity currentUser) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Call the user's CollectionReference to add a new user
    users
        .doc(currentUser.id)
        .set({
          'full_name': currentUser.name,
          'user_email': currentUser.email,
          'user_phone': currentUser.phone
        })
        .
    //then((value) => prefs.setBool(IS_LOGIN, true)).
    then((value) => prefs.setString(USER_NAME, currentUser.name)).
    then((value) => Provider.of<LoginProvider>(context,listen: false).getSPuserNameValue()).
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
