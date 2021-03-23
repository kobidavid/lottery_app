import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';
import 'package:lottery_app/presentation/pages/home_page.dart';
import 'package:lottery_app/presentation/pages/login_page.dart';
import 'package:lottery_app/presentation/pages/payment_page.dart';
import 'package:lottery_app/presentation/state_management/register_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/custom_widgets.dart'; //contains all custom widgets under /lib/presentation/widget
import 'package:google_sign_in/google_sign_in.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();

  TextEditingController userIdController = TextEditingController();

  TextEditingController userPhoneNumberController = TextEditingController();

  TextEditingController userEmailController = TextEditingController();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  UserEntity userEntity;


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
                        child: ReusableTextField(
                            userNameController: userNameController,
                            labelName: "שם משתמש",
                            returnErr: "נא הזן שם משתמש",
                            textDirection: TextDirection.rtl)),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: ReusableTextField(
                            userNameController: userIdController,
                            labelName: "תעודת זהות",
                            returnErr: "נא הזן תעודת זהות",
                            textDirection: TextDirection.rtl)),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: ReusableTextField(
                            userNameController: userPhoneNumberController,
                            labelName: "טלפון נייד",
                            returnErr: "נא הזן טלפון נייד",
                            textDirection: TextDirection.rtl)),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: ReusableTextField(
                            userNameController: userEmailController,
                            labelName: "אימייל",
                            returnErr: "כתובת אימייל לא תקינה",
                            textDirection: TextDirection.ltr)),
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
                            print(user.id);
                            /* Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));*/
                            //print(userEmailController.text);
                            // signInWithGoogle();

                            CollectionReference users =
                                FirebaseFirestore.instance.collection('users');

                            users
                                .doc(user.id)
                                .set({
                                  'full_name': user.name,
                                  'user_id': user.id,
                                  'user_phone': user.phone,
                                  'user_email': user.email,
                                })
                                .then((value) => print("User Added"))
                                .then((value) => addToSharedPrefAsRegister())
                                .then((value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PaymentPage()))
                                .catchError((error) =>
                                    print("Failed to add user: $error"))
                                .then((value) => print('fff')));
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

addToSharedPrefAsRegister() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isRegister', true);
}
