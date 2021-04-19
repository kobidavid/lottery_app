import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lottery_app/core/di/di.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';
import 'package:lottery_app/loginF/core/flash_alert.dart';

class RegisterProvider extends ChangeNotifier {
  final UserEntity currentUser;
  bool userAlreadyRegisterInThePast;
  final GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  RegisterProvider() : currentUser = getIt(),
  userAlreadyRegisterInThePast=false;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() async {

    if (fbKey.currentState.saveAndValidate()) {
      currentUser.name = fbKey.currentState.fields['userName'].value;
      currentUser.id = fbKey.currentState.fields['userId'].value;
      currentUser.phone = fbKey.currentState.fields['userPhone'].value;
      currentUser.email = fbKey.currentState.fields['userEmail'].value;

      final snapShot = await users.doc(currentUser.id).get();

      if (snapShot == null || !snapShot.exists) {
        await saveOnFirestore();
      } else {

       // showFlushbar1(context);
        //print("user already registered exists in the system");
        //userAlreadyRegisterInThePast=true;
        //notifyListeners();

      }
    }
  }

  Future saveOnFirestore() {
    // Call the user's CollectionReference to add a new user
    users
        .doc(currentUser.id)
        .set({
          'full_name': currentUser.name,
          'user_email': currentUser.email,
          'user_phone': currentUser.phone
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}

/*  Future<void> registerComplete() async {

    if (fbKey.currentState.validate()) {
      print(fbKey.currentState.context);

      currentUser.name = fbKey.currentState.value['Name'];
      currentLoggedInUser.bio = fbKey.currentState.value['Bio'];

      Either<FirebaseDataSaved, FirebaseCommunicationFailure> saveResult =
      await saveUserOnFirestore(currentLoggedInUser);

      saveResult.fold(
            (success) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool(IS_REGISTERED, true);
          navigateToFeedpage();
        },
            (failed) {},
      );
    }
  }*/

/*Future<Either<FirebaseDataSaved, FirebaseCommunicationFailure>>
  saveUserOnFirestore( UserEntity userToSave) async {

    try {
      await users.doc(userToSave.id).set({
        'full_name': userToSave.name,
        'user_email': userToSave.email,
        'user_phone': userToSave.phone,
      });
    } catch (err) {
      print('save user failed $err');
      return Right(FirebaseCommunicationFailure());
    }

    return Left(FirebaseDataSaved());
  }*/
