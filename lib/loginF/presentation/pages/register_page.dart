import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lottery_app/core/widget/register_textfield_widget.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';
import 'package:lottery_app/loginF/core/flash_alert.dart';
import 'package:lottery_app/loginF/domain/repositories/db_queries_interface.dart';
import 'package:lottery_app/loginF/presentation/pages/login_page.dart';
import 'package:lottery_app/loginF/presentation/state_management/login_provider.dart';
import 'package:lottery_app/loginF/presentation/state_management/register_provider.dart';
import 'package:lottery_app/presentation/pages/payment_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  //final formKey = GlobalKey<FormBuilderState>();
  //final fbKey = Provider.of<RegisterProvider>(context, listen: false).fbKey,
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
                key:
                    Provider.of<RegisterProvider>(context, listen: false).fbKey,
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
                    Row(
                      children: [
                        Expanded(
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: RegisterTextField(
                                  //controller: userNameController,
                                  name: "userLastName",
                                  keyboardType: TextInputType.name,
                                  labelName: "שם משפחה",
                                  returnErr: "נא הזן שם משפחה",
                                  charLength: 0,
                                  textDirection: TextDirection.rtl)),
                        ),
                        Expanded(
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: RegisterTextField(
                                  //controller: userNameController,
                                  name: "userFirstName",
                                  keyboardType: TextInputType.name,
                                  labelName: "שם פרטי",
                                  returnErr: "נא הזן שם פרטי",
                                  charLength: 0,
                                  textDirection: TextDirection.rtl)),
                        ),
                      ],
                    ),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: RegisterTextField(
                            //controller: userIdController,
                            name: "userId",
                            keyboardType: TextInputType.phone,
                            labelName: "תעודת זהות",
                            returnErr: "נא הכנס תעודת זהות",
                            charLength: 0,
                            textDirection: TextDirection.rtl)),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: RegisterTextField(
                            name: "userPhone",
                            //controller: userPhoneNumberController,
                            keyboardType: TextInputType.phone,
                            labelName: "טלפון נייד",
                            returnErr: "נא הכנס טלפון נייד",
                            charLength: 0,
                            textDirection: TextDirection.ltr)),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: RegisterTextField(
                            name: "userEmail",
                            //controller: userEmailController,
                            keyboardType: TextInputType.emailAddress,
                            labelName: "אימייל",
                            returnErr: "נא הכנס כתובת אימייל",
                            charLength: 0,
                            textDirection: TextDirection.ltr)),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        child: Text('רישום'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange)),
                        onPressed: () {
                          Provider.of<RegisterProvider>(context, listen: false)
                              .registerUser(context);
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
}


/*
addToSharedPrefAsRegister() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isRegister', true);
}
*/
