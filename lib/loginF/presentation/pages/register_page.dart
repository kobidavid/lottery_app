import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lottery_app/core/widget/register_textfield_widget.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';
import 'package:lottery_app/loginF/core/flash_alert.dart';
import 'package:lottery_app/loginF/domain/repositories/db_queries.dart';
import 'package:lottery_app/loginF/presentation/pages/login_page.dart';
import 'package:lottery_app/loginF/presentation/state_management/login_provider.dart';
import 'package:lottery_app/loginF/presentation/state_management/register_provider.dart';
import 'package:lottery_app/presentation/pages/payment_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flash/flash.dart';

import '../../../main.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //UserEntity currentUser;

  /*TextEditingController userNameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();*/

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    //userNameController.addListener(() {print(userNameController.text); });

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding:
                  EdgeInsets.only(left: 50, right: 50, top: 30, bottom: 30),
              child: FormBuilder(
                autovalidateMode: AutovalidateMode.always,
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'הצטרף ללוטו דראעק',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: RegisterTextField(
                            //controller: userNameController,
                            name: "userName",
                            labelName: "שם משתמש",
                            returnErr: "נא הזן שם משתמש",
                            textDirection: TextDirection.rtl)),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: RegisterTextField(
                            //controller: userIdController,
                            name: "userId",
                            labelName: "תעודת זהות",
                            returnErr: "נא הכנס תעודת זהות",
                            textDirection: TextDirection.rtl)),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: RegisterTextField(
                            name: "userPhone",
                            //controller: userPhoneNumberController,
                            labelName: "טלפון נייד",
                            returnErr: "נא הכנס טלפון נייד",
                            textDirection: TextDirection.rtl)),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: RegisterTextField(
                            name: "userEmail",
                            //controller: userEmailController,
                            labelName: "אימייל",
                            returnErr: "נא הכנס כתובת אימייל",
                            textDirection: TextDirection.ltr)),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                        child: Text('רישום'),
                        color: Colors.red,
                        onPressed: () {
                          if (formKey.currentState.saveAndValidate()) {
                            UserEntity currentUser =UserEntity();
                            currentUser.name = formKey.currentState.fields['userName'].value;
                            currentUser.id = formKey.currentState.fields['userId'].value;
                            currentUser.phone = formKey.currentState.fields['userPhone'].value;
                            currentUser.email = formKey.currentState.fields['userEmail'].value;
                            DBQueries ddd=DBQueries();
                            ddd.addUser(context,currentUser);
                            //Provider.of<LoginProvider>(context,listen: false).getSPuserNameValue();
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      child: Container(
                        child: Text('כבר רשום? מחכים לך כאן'),
                      ),
                      onTap: () {
                        print('ddd');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginPage()));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () => showFlushbar1(context),
                      child: Text('Basics | Duration'),
                    ),
                    /* Center(
                      child: Consumer<RegisterProvider>(
                          builder: (context, registerProviderProvider, child) {
                        return Text(registerProviderProvider.a.toString());
                      }),
                    )*/
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget _showBasicsFlash({
    Duration duration,
    flashStyle = FlashStyle.floating,
  }) {
    showFlash(
      context: context,
      duration: duration,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          style: flashStyle,
          boxShadows: kElevationToShadow[4],
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: FlashBar(
            message: Text('This is a basic flash'),
          ),
        );
      },
    );
  }
}

/*
addToSharedPrefAsRegister() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isRegister', true);
}
*/
