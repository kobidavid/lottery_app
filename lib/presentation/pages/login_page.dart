import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:io' as io;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottery_app/presentation/pages/register_page.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Container(padding:
          EdgeInsets.only(left: 50, right: 50, top: 30, bottom: 30),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [SizedBox(height: 20,),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      'היי, כיף לראות אותך שוב',
                      style: TextStyle(fontSize: 17),
                    )),
                SizedBox(height: 30,),
                Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      'נא התחבר',
                      style: TextStyle(fontSize: 30),
                    )),SizedBox(height: 20,),
                GoogleSignInButton(
                  onPressed: () {signInWithGoogle();},
                  darkMode: false,
                  textStyle: TextStyle(fontSize: 20),// default: false

                ),
                SizedBox(
                  height: 20,
                ),
                FacebookSignInButton(
                 onPressed: (){
                   signInWithFacebook();
                 },


                ),
                SizedBox(
                  height: 20,
                ),
                AppleSignInButton(
                    onPressed: () async {final oauthCred = await _createAppleOAuthCred();
                    await FirebaseAuth.instance.signInWithCredential(oauthCred);},
                    textStyle: TextStyle(fontSize: 20),// default: false


                ),
                SizedBox(
                  height: 20,
                ),
                Directionality(textDirection: TextDirection.rtl,
                  child: GestureDetector(
                    child: Container(
                      child: Text('לא רשום? לדף הרישום'),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

String _createNonce(int length) {
  final random = Random();
  final charCodes = List<int>.generate(length, (_) {
    int codeUnit;

    switch (random.nextInt(3)) {
      case 0:
        codeUnit = random.nextInt(10) + 48;
        break;
      case 1:
        codeUnit = random.nextInt(26) + 65;
        break;
      case 2:
        codeUnit = random.nextInt(26) + 97;
        break;
    }

    return codeUnit;
  });

  return String.fromCharCodes(charCodes);
}

Future<OAuthCredential> _createAppleOAuthCred() async {
  final nonce = _createNonce(32);
  final nativeAppleCred = io.Platform.isIOS
      ? await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    nonce: sha256.convert(utf8.encode(nonce)).toString(),
  )
      : await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
    webAuthenticationOptions: WebAuthenticationOptions(
      redirectUri: Uri.parse(
          'https://com.kobi.lotteryApp/__/auth/handler'),
      clientId: '84159679458-lf4nh23noabbbnuhj6o0qie147alssrp.apps.googleusercontent.com',
    ),
    nonce: sha256.convert(utf8.encode(nonce)).toString(),
  );

  return new OAuthCredential(
    providerId: "apple.com", // MUST be "apple.com"
    signInMethod: "oauth",   // MUST be "oauth"
    accessToken: nativeAppleCred.identityToken, // propagate Apple ID token to BOTH accessToken and idToken parameters
    idToken: nativeAppleCred.identityToken,
    rawNonce: nonce,
  );
}

Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult result = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final FacebookAuthCredential facebookAuthCredential =
  FacebookAuthProvider.credential(result.accessToken.token);

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}