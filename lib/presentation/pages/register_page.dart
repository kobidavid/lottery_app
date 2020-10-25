import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';
import 'package:lottery_app/presentation/pages/login_page.dart';

import 'package:google_sign_in/google_sign_in.dart';


class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();

  //FirebaseFirestore fireStore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth= FirebaseAuth.instance;

  UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding:
                  EdgeInsets.only(left: 50, right: 50, top: 30, bottom: 30),
              child: Form(
                key: _formKey,
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
                        child: TextFormField(
                          controller: userNameController,
                          decoration: InputDecoration(
                              labelText: 'שם משתמש', alignLabelWithHint: false),
                          textDirection: TextDirection.rtl,
                          onSaved: (String value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "נא הזן שם משתמש";
                            }
                            //return value.contains('@') ? 'Do not use the @ char.' : null;
                          },
                        )),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                            controller: userIdController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'תעודת זהות',
                                alignLabelWithHint: false),
                            textDirection: TextDirection.rtl,
                            onSaved: (String value) {
                              // This optional block of code can be used to run
                              // code when the user saves the form.
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "נא הזן תעודת זהות";
                              }
                              //return value.contains('@') ? 'Do not use the @ char.' : null;
                            })),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                            controller: userPhoneNumberController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'טלפון נייד',
                                alignLabelWithHint: false),
                            textDirection: TextDirection.rtl,
                            onSaved: (String value) {
                              // This optional block of code can be used to run
                              // code when the user saves the form.
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "נא הזן טלפון נייד ";
                              }
                              //return value.contains('@') ? 'Do not use the @ char.' : null;
                            })),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                            controller: userEmailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'אימייל', alignLabelWithHint: false),
                            textDirection: TextDirection.rtl,
                            onSaved: (String value) {
                              // This optional block of code can be used to run
                              // code when the user saves the form.
                            },
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "נא הזן כתובת אימייל ";
                              }
                              return !value.contains('@')
                                  ? 'כתובת אימייל לא תקינה'
                                  : null;
                            })),
                    SizedBox(
                        height: 20,
                    ),
                    RaisedButton(
                        child: Text('רישום'),
                        color: Colors.red,
                        onPressed: () {
                          UserEntity user = UserEntity(
                              id: userIdController.text,
                              name: userNameController.text,
                              phone: userPhoneNumberController.text,
                              email: userEmailController.text);

                          if (_formKey.currentState.validate()) {
                            /* Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));*/
                            //print(userEmailController.text);
                           // signInWithGoogle();

                           /* CollectionReference users =
                                fireStore.instance.collection('users');

                            users
                                .doc(user.id)
                                .set({
                                  'full_name': user.name, // John Doe
                                  'user_id': user.id, // John Doe
                                  'user_phone': user.phone, // Stokes and Sons
                                  'user_email': user.email, // Stokes and Sons
                                })
                                .then((value) => print("User Added"))
                                .catchError((error) =>
                                    print("Failed to add user: $error"));*/
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
