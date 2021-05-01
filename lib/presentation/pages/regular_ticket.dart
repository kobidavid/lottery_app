import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottery_app/core/shared_preferences_names.dart';
import 'package:lottery_app/loginF/presentation/pages/login_page.dart';
import 'package:lottery_app/loginF/presentation/pages/register_page.dart';
import 'package:lottery_app/loginF/presentation/state_management/register_provider.dart';
import 'package:lottery_app/presentation/pages/payment_page.dart';
import 'package:lottery_app/loginF/presentation/state_management/login_provider.dart';
import 'package:lottery_app/presentation/state_management/ticket_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/widget/custom_widgets.dart'; //contains all custom widgets under /lib/presentation/widget

class RegularTicket extends StatefulWidget {
  @override
  _RegularTicketState createState() => _RegularTicketState();
}

class _RegularTicketState extends State<RegularTicket> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // ScrollController is needed to recognized when the user reach to the bottom of the page
  // and than to change the send button position to the middle.
  //var _scrollController = ScrollController();

/*
  @override
  void initState() {
    super.initState();
    // Setup the listener.
    final ticketProvider = Provider.of<TicketProvider>(context, listen: false);
    _scrollController.addListener(() {
      print(_scrollController.position);
      if (_scrollController.offset <= 300) {
        //if (_scrollController.position.pixels == 0) {
        ticketProvider.positionOfSendButton("bottom");
      } else {
        ticketProvider.positionOfSendButton("center");
      }
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        // choose an option: 2/4/6/8/10/12/14
        Container(
          height: 80,
          /*color:Color(0xffc8009f),*/
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff0F283F), Color(0xffA2D0FB)],
            ),
          ),
          child: DesiredNumOfTables(),
        ),

        Expanded(
          child: Stack(
            children: <Widget>[
              ListView(
                //controller: _scrollController,
                children: <Widget>[
                  Consumer<TicketProvider>(
                      builder: (context, ticketProvider, child) {
                    return Column(
                      children: List.generate(
                        (TicketProvider.currentNumOnRow * 2) + 2,
                        //num of rows
                        (index) => oneLuckyTable(context, index),
                      ),
                    );
                  })
                ],
              ),
            ],
          ),
        ),
        Consumer<TicketProvider>(builder: (context, ticketProvider, child) {
          return GestureDetector(
            child: Container(
              alignment: Alignment.center,
              height: 60,
              color: Colors.blue,
              child: Text('שליחה',
                  style: TextStyle(fontSize: 50, color: Colors.white)),
            ),
            onTap: () async {
              //addToSharedPrefAsRegister();

              ticketProvider.transferBoolArrayToInt();
              if( TicketProvider.missing_checkboxes==false){
                print('ticket is ok');

                if ( auth.currentUser==null){

                  print("user is not register");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                  TicketProvider.missing_checkboxes=true;
                }
                else{
                  Navigator.of(
                    context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(),
                    ),
                  );
                  TicketProvider.missing_checkboxes=true;
                }
              }else{
                print('Ticket hasnt been filed completly ');
              }
              });
        })
      ]),
    );
  }
}


Future<bool> getBoolValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return bool
  //print (prefs.getBool('isRegister'));   /true or false
  final myBool = prefs.getBool('my_bool_key') ?? false;
  return prefs.getBool('isRegister');

}

addToSharedPrefAsRegister() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('isRegister', true);
}