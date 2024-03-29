import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:io' as io;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lottery_app/core/widget/register_textfield_widget.dart';
import 'package:lottery_app/loginF/presentation/pages/register_page.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:lottery_app/loginF/presentation/state_management/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flash/flash.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatelessWidget {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Container(
            //padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/7, right: MediaQuery.of(context).size.width/7, top: 30, bottom: 30),
            margin: EdgeInsets.all(40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'היי, כיף לראות אותך שוב',
                        style: TextStyle(fontSize: 17),
                      )),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'נא התחבר',
                        style: TextStyle(fontSize: 30),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FormBuilder(
                    key: Provider.of<LoginProvider>(context, listen: false)
                        .fbKey,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: RegisterTextField(
                        controller: textEditingController,
                        name: "login_with_phone",
                        textDirection: TextDirection.ltr,
                        keyboardType: TextInputType.phone,
                        labelName: "התחבר באמצעות מספר טלפון",
                        icon: Icon(Icons.phone),
                        charLength: 0,
                        returnErr: '',
                      ),
                    ),
                  ),
                  Consumer<LoginProvider>(
                      builder: (context, loginProviderPhoneNumber, child) {
                    return loginProviderPhoneNumber.charLength > 8
                        ? GestureDetector(
                            onTap: () {
                              Provider.of<LoginProvider>(context, listen: false)
                                  .loginUserByPhoneNum(
                                      context,
                                      loginProviderPhoneNumber.charValue
                                          .toString()
                                          .trim());
                            },
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("שליחת קוד")),
                          )
                        : Text("");
                  }),
                  SizedBox(
                    height: 40,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 20.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                    Text("או"),
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  SignInButton(
                    Buttons.Google,
                    onPressed: () {
                      Provider.of<LoginProvider>(context, listen: false)
                          .signInWithGoogle(context);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /*  FacebookSignInButton(
                    onPressed: () {
                      //signInWithFacebook();
                    },
                  ), */
                  SizedBox(
                    height: 20,
                  ),
                  /* AppleSignInButton(
                    onPressed: () async {
                      final oauthCred = await _createAppleOAuthCred();
                      await FirebaseAuth.instance
                          .signInWithCredential(oauthCred);
                    },
                    textStyle: TextStyle(fontSize: 20), // default: false
                  ), */
                  SizedBox(
                    height: 20,
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: GestureDetector(
                      child: Container(
                        child: Text('לא רשום? לדף הרישום'),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
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
      ),
    );
  }
}

String? _createNonce(int length) {
  final random = Random();
  final charCodes = List<int>.generate(length, (_) {
    late int codeUnit;

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
          nonce: sha256.convert(utf8.encode(nonce!)).toString(),
        )
      : await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            redirectUri:
                Uri.parse('https://com.kobi.lotteryApp/__/auth/handler'),
            clientId:
                '84159679458-lf4nh23noabbbnuhj6o0qie147alssrp.apps.googleusercontent.com',
          ),
          nonce: sha256.convert(utf8.encode(nonce!)).toString(),
        );

  return new OAuthCredential(
    providerId: "apple.com",
    // MUST be "apple.com"
    signInMethod: "oauth",
    // MUST be "oauth"
    accessToken: nativeAppleCred.identityToken,
    // propagate Apple ID token to BOTH accessToken and idToken parameters
    idToken: nativeAppleCred.identityToken,
    rawNonce: nonce,
  );
}

/*Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult result = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final FacebookAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(result.accessToken.token);

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance
      .signInWithCredential(facebookAuthCredential);
}*/
