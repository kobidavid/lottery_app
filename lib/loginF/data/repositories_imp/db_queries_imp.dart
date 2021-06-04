import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery_app/core/service_locator.dart';
import 'package:lottery_app/data/firestore_service.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';
import 'package:lottery_app/loginF/core/flash_alert.dart';
import 'package:lottery_app/loginF/domain/repositories/db_queries_interface.dart';
import 'package:lottery_app/presentation/pages/payment_page.dart';
import 'package:lottery_app/presentation/state_management/ticket_provider.dart';

class DBQueriesImp extends DBQueriesInterface {
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  var currentUser = locator<UserEntity>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> checkIfUserEmailOrPassExist(context, email, phoneNumber) async {
    var dataPhone =
        await users.where("user_phone", isEqualTo: phoneNumber).get();
    var dataEmail = await users.where("user_email", isEqualTo: email).get();

    if (dataEmail.size > 0 || dataPhone.size > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkIfEmailExist(context) async {
    final snapShot = await users.doc(auth.currentUser.email).get();

    if (snapShot == null || !snapShot.exists) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkIfEmailExistInFireStore(context, String email) async {
    var data = await users.where("user_email", isEqualTo: email).get();
    return data.size > 0;
  }

  /*Future<String> returnUserNameInFireStore(String emailOrPhone) async {
    if (emailOrPhone.contains("@")) {
      var data = await users.where("user_email", isEqualTo: emailOrPhone).get();
      if (data.size > 0) {
        return (data.docs.first["first_name"]);
      } else {
        return "";
      }
    } else {
      var data = await users.where("user_phone", isEqualTo: emailOrPhone).get();
      if (data.size > 0) {
        return (data.docs.first["first_name"]);
      } else {
        return "";
      }
    }


  }*/
  Future<String> returnUserNameInFireStore() async {
    if (auth.currentUser != null) {
      var data = await users.where(
          "user_email", isEqualTo: auth.currentUser.email).get();
      if (data.size > 0) {
        return (data.docs.first["first_name"]);
      } else {
        var data = await users.where(
            "user_phone", isEqualTo: auth.currentUser.phoneNumber).get();
        if (data.size > 0) {
          return (data.docs.first["first_name"]);
        }
      }
    }
  }
  Future<bool> checkIfPhoneExist(context, String phoneNumber) async {
    //users.where("user_phone", isEqualTo: phoneNumber).snapshots().listen((event) {return event.docs[0];});
    var data = await users.where("user_phone", isEqualTo: phoneNumber).get();
    return data.docs.length > 0;
  }

  Future<void> registerUser(context,bool isLoginMethod) async {
    var currentUer = locator<UserEntity>();
    print(currentUer.lastName);
    final snapShot = await users.doc(auth.currentUser.uid).get();

    if (snapShot == null || !snapShot.exists) {
      await _saveOnFirestore(context);

    } else if(isLoginMethod==false){
      showFlushbar1(context, text: "המשתמש קיים במערכת");
    }
  }

  Future<void> _saveOnFirestore(context) async {
    print('ddd');

    // Call the user's CollectionReference to add a new user
    users
        .doc(auth.currentUser.uid)
        .set({
          'first_name': currentUser.firstName,
          'last_name': currentUser.lastName,
          'user_email': currentUser.email,
          'user_phone': currentUser.phone,
          'user_id': currentUser.id
        })
        .
        //then((value) => prefs.setBool(IS_LOGIN, true)).
        //then((value) => Provider.of<LoginProvider>(context,listen: false).getSPuserNameValue()).
        then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => PaymentPage())))
        .
        //then((value) => _prefs.setString(USER_EMAIL, currentUser.email)).
        catchError((error) => print("Failed to add user: $error"));
  }




  Future<void> findUserDoc(List myIntList,List myIntStrongList,numOfRows,int price) async {


    // Call the user's CollectionReference to add a new user
    var dataEmail= await users.where("user_email",isEqualTo: currentUser.email).get();
String userDocId=dataEmail.docs.first.id;
   //return userDocId;
    FirestoreService firestoreService=FirestoreService();
    firestoreService.addUser(myIntList, myIntStrongList, numOfRows,userDocId,price);
     users.doc(userDocId).update({
      'aaa':TicketProvider.myIntStrongList[0][0][0]
    /*  'last_name': currentUer.lastName,
      'user_email': currentUer.email,
      'user_phone': currentUer.phone,
      'user_id': currentUer.id
    })
        .
    //then((value) => prefs.setBool(IS_LOGIN, true)).
    //then((value) => Provider.of<LoginProvider>(context,listen: false).getSPuserNameValue()).
    then((value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => PaymentPage())))
        .
    //then((value) => _prefs.setString(USER_EMAIL, currentUser.email)).
    catchError((error) => print("Failed to add user: $error"));
  }*/

});}}



