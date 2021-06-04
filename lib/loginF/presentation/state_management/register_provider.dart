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
import 'package:lottery_app/loginF/core/verify_auth_phone_number.dart';
import 'package:lottery_app/loginF/data/repositories_imp/db_queries_imp.dart';
import 'package:lottery_app/loginF/domain/repositories/db_queries_interface.dart';
import 'package:lottery_app/loginF/presentation/pages/register_page.dart';
import 'package:lottery_app/loginF/presentation/pages/verification_code_page.dart';
import 'package:lottery_app/loginF/presentation/state_management/login_provider.dart';
import 'package:lottery_app/presentation/pages/payment_page.dart';
import 'package:provider/provider.dart';

class RegisterProvider extends ChangeNotifier {
  bool userAlreadyRegisterInThePast;

  final GlobalKey<FormBuilderState> fbKey = GlobalKey<FormBuilderState>();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  FirebaseAuth auth = FirebaseAuth.instance;
  DBQueriesImp dbQueriesImp = DBQueriesImp();

  Future<void> registerUser(context) async {
    if (fbKey.currentState.saveAndValidate()) {
      if (await dbQueriesImp.checkIfUserEmailOrPassExist(context,fbKey.currentState.fields["userEmail"].value.toString().trim(),fbKey.currentState.fields["userPhone"].value.toString().trim())==true){

        showFlushbar1(context, text: "המשתמש קיים במערכת");
      }else{
      var currentUser = locator<UserEntity>();
      currentUser.firstName = fbKey.currentState.fields['userFirstName'].value;
      currentUser.lastName = fbKey.currentState.fields['userLastName'].value;
      currentUser.id = fbKey.currentState.fields['userId'].value;
      currentUser.phone = fbKey.currentState.fields['userPhone'].value;
      currentUser.email = fbKey.currentState.fields['userEmail'].value;

      bool isLoginMethod=false;
      VerifyAuthPhoneNumber verifyAuthPhoneNumber=VerifyAuthPhoneNumber();
      await verifyAuthPhoneNumber.verifyAuthPhoneNum(currentUser.phone, context,isLoginMethod);}
    }
  }



  signIn(verificationId, smsCode, context,bool isLoginMethod) async {
    AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    UserCredential result = await auth.signInWithCredential(credential);
    User user = result.user;
    if (user != null) {

      dbQueriesImp.registerUser(context,isLoginMethod);
      Provider.of<LoginProvider>(context,listen: false).userNameForIcon();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PaymentPage()));
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RegisterPage()));
    }
  }

  int charLength=0;
  String charValue;
  onChanged(String value) {
    charValue=value;
    charLength = value.length;

    notifyListeners();
  }
}
