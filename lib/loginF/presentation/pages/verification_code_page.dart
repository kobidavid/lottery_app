import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:lottery_app/loginF/presentation/state_management/register_provider.dart';

class VerificationCodePage extends StatefulWidget {
  String phoneNumber;
  String verificationId;

  VerificationCodePage({
    this.phoneNumber,this.verificationId
  });
  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();

}

class _VerificationCodePageState extends State<VerificationCodePage> {

  bool _onEditing = true;
  String _code;
  TextEditingController inputCode=TextEditingController();
  bool hasError = false;
  String currentText = "";
  StreamController<ErrorAnimationType> errorController;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/14,top:MediaQuery.of(context).size.height/10,right:MediaQuery.of(context).size.width/14),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: Text('בודקים שהמספר נכון וסיימנו')),
                SizedBox(height: 20,),
                Center(child: Text('נא להזין את הקוד שנשלח אליכם',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
                Center(child: Text( widget.phoneNumber+' למספר',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
            /*VerificationCode(
              textStyle: TextStyle(fontSize: 13.0, color: Colors.red[900]),
              underlineColor: Colors.amber,
              keyboardType: TextInputType.number,

              length: 4,
              // clearAll is NOT required, you can delete it
              // takes any widget, so you can implement your design
              clearAll: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  'clear all',
                  style: TextStyle(
                      fontSize: 14.0,
                      decoration: TextDecoration.underline,
                      color: Colors.blue[700]),
                ),
              ),onEditing: (bool value) {
              setState(() {
                _onEditing = value;
              });
            },
              onCompleted: (String value) {
                setState(() {
                  _code = value;
                });
                RegisterProvider().signIn(widget.verificationId,_code,context);

              },)*/
              PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                obscureText: true,
                obscuringCharacter: '*',
                obscuringWidget: FlutterLogo(
                  size: 24,
                ),
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v.length < 3) {
                    return "I'm from validator";
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor:
                  hasError ? Colors.blue.shade100 : Colors.white,
                ),
                cursorColor: Colors.black,
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: inputCode,
                keyboardType: TextInputType.number,
                boxShadows: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) {
                  print("Completed");
                },
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ),

                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: inputCode,

          ),ElevatedButton(child:Text('אשר'),onPressed: (){
                  RegisterProvider().signIn(widget.verificationId,inputCode.text,context);
                }),

                //Center(child: Text(_code!=null?_code:"",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
