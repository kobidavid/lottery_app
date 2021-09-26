import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery_app/loginF/presentation/pages/verification_code_page.dart';

class VerifyAuthPhoneNumber {
  Future verifyAuthPhoneNum(
      String phoneNumber, context, bool isLoginMethod) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      timeout: Duration(seconds: 60),
      // after this timeout the code will be expired

      verificationCompleted: (AuthCredential credential) async {
        // callback which gets called once the verification successfully using auto code retrival ,not manually!!!
      },

      verificationFailed: (FirebaseAuthException exception) {
        // callback which gets called when the verification failed,
        print(exception);
      },
      codeSent: (String verificationId, int? resendToken) async {
        // callback which gets called when the code send successfully to the device,
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VerificationCodePage(
                      phoneNumber: phoneNumber,
                      verificationId: verificationId,
                      isLoginMethod: isLoginMethod,
                    )));
      },

      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
