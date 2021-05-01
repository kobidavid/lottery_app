import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:lottery_app/core/di/di.dart';
import 'package:lottery_app/core/service_locator.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';
import 'package:lottery_app/loginF/core/flash_alert.dart';
import 'package:lottery_app/loginF/data/repositories_imp/db_queries_imp.dart';
import 'package:lottery_app/loginF/domain/repositories/db_queries_interface.dart';
import 'package:lottery_app/loginF/presentation/pages/register_page.dart';
import 'package:lottery_app/loginF/presentation/pages/verification_code_page.dart';
import 'package:lottery_app/presentation/pages/payment_page.dart';

class RegisterProvider extends ChangeNotifier {
  bool userAlreadyRegisterInThePast;

  final GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  //userAlreadyRegisterInThePast=false;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  FirebaseAuth auth = FirebaseAuth.instance;
  DBQueriesImp dbQueriesImp = DBQueriesImp();

  Future<void> registerUser(context) async {
    if (fbKey.currentState.saveAndValidate()) {
      if (await dbQueriesImp.checkIfUserExist(context)==true){

        showFlushbar1(context, text: "המשתמש קיים במערכת");
      }else{
      var currentUser = locator<UserEntity>();
      currentUser.firstName = fbKey.currentState.fields['userFirstName'].value;
      currentUser.lastName = fbKey.currentState.fields['userLastName'].value;
      currentUser.id = fbKey.currentState.fields['userId'].value;
      currentUser.phone = fbKey.currentState.fields['userPhone'].value;
      currentUser.email = fbKey.currentState.fields['userEmail'].value;

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+972534427026',

        timeout: Duration(seconds: 60),   // after this timeout the code will be expired

        verificationCompleted: (AuthCredential credential) async {  // callback which gets called once the verification successfully using auto code retrival ,not manually!!!
          /*UserCredential authResult =
              await auth.signInWithCredential(credential);

          User user = authResult.user;
          if (user != null) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PaymentPage()));
          }*/
        },

        verificationFailed: (FirebaseAuthException exception) {   // callback which gets called when the verification failed,
          print(exception);
        },
        codeSent: (String verificationId, int resendToken)  async{      // callback which gets called when the code send successfully to the device,
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VerificationCodePage(
                      phoneNumber: currentUser.phone,
                      verificationId: verificationId)));
        },

        codeAutoRetrievalTimeout: (String verificationId) {}  ,
      );}
    }
  }

  signIn(verificationId, smsCode, context) async {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    UserCredential result = await auth.signInWithCredential(credential);
    User user = result.user;
    if (user != null) {

      dbQueriesImp.registerUser(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PaymentPage()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RegisterPage()));
    }
  }
}
