import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottery_app/core/constants/app_colors.dart';
import 'package:lottery_app/presentation/pages/login_page.dart';
import 'package:lottery_app/presentation/pages/register_page.dart';
import 'package:lottery_app/presentation/pages/payment_page.dart';
import 'package:lottery_app/presentation/state_management/login_provider.dart';
import 'package:lottery_app/presentation/state_management/ticket_provider.dart';
import 'package:lottery_app/presentation/widget/desired_num_of_tables.dart';
import 'package:provider/provider.dart';

class RegularTicket extends StatelessWidget {
  final int ind = 0;

  //bool isStrongNum=true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            body: Column(children: [
              Container(
                height: 80,
                /*color:Color(0xffc8009f),*/
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xff0F283F), Color(0xffA2D0FB)])),
                child: DesiredNumOfTables(),
              ),
              /*Expanded(
            child: ListView(
              children: <Widget>[
                Column(
                  children: List.generate(
                    8,
                    (index) => oneLuckyTable(context, index),
                  ),
                ),
              ],
            ),
          ),*/

              Expanded(
                child: Stack(
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        Consumer<TicketProvider>(
                            builder: (context, ticketProvider, child) {
                          return Column(
                            children: List.generate(
                              (TicketProvider.currentNumOnRow * 2) + 2,
                              (index) => oneLuckyTable(context, index),
                            ),
                          );
                        })
                      ],
                    ),
                    Consumer<TicketProvider>(
                        builder: (context, ticketProvider, child) {
                      return Positioned.fill(
                          child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: RaisedButton(
                                    color: Color(0xff472bff),
                                    child: Text(
                                      "שליחה",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 26),
                                    ),
                                    onPressed: () {
                                      FirebaseAuth.instance
                                          .authStateChanges()
                                          .listen((User user) {
                                        if (user == null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterPage(),
                                            ),
                                          );
                                        } else {
                                          ticketProvider.transferBoolArrayToInt();
                                          /*if (ticketProvider
                                              .transferBoolArrayToInt()) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentPage(),
                                              ),
                                            );
                                          }*/
                                        }
                                      });

                                      /*Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginPage(),
                                        ),
                                      );*/
                                    },
                                  ))));
                    }),
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}

oneLuckyTable(BuildContext context, int rowNumber) {
  return Consumer<TicketProvider>(builder: (context, ticketProviderr, child) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 105,
        //color: rowNumber % 2 == 0 ? Colors.pink.shade100 : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: rowNumber % 2 == 0
                  ? AppColors.PINK_BACKGROUND_COLOR
                  : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Container(
                      margin: EdgeInsets.all(0),
                      height: 10,
                      padding: EdgeInsets.all(0),
                      width: 19,
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: FaIcon(
                          FontAwesomeIcons.magic,
                          color: Colors.indigo,
                          size: 16,
                        ),
                        onPressed: () {
                          ticketProviderr.randomRow(rowNumber);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(0),
                      height: 10,
                      padding: EdgeInsets.all(0),
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        icon: FaIcon(
                          FontAwesomeIcons.trashAlt,
                          color: AppColors.RED_BUTTON_BORDER_COLOR,
                          size: 16,
                        ),
                        onPressed: () {
                          ticketProviderr.deleteCurrentRow(rowNumber);
                        },
                      ),
                    ),
                    DesignButton(
                        number: 1, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 2, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 3, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 4, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 5, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 6, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 7, rowNum: rowNumber, isStrongNum: false),
                  ]),
                  Row(children: [
                    DesignButton(
                        number: 8, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 9, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 10, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 11, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 12, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 13, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 14, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 15, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 16, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 17, rowNum: rowNumber, isStrongNum: false),
                  ]),
                  Row(children: [
                    DesignButton(
                        number: 18, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 19, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 20, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 21, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 22, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 23, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 24, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 25, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 26, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 27, rowNum: rowNumber, isStrongNum: false),
                  ]),
                  Row(children: [
                    DesignButton(
                        number: 28, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 29, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 30, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 31, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 32, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 33, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 34, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 35, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 36, rowNum: rowNumber, isStrongNum: false),
                    DesignButton(
                        number: 37, rowNum: rowNumber, isStrongNum: false),
                  ]),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              child: VerticalDivider(
                thickness: 1,
                color: Colors.black,
              ),
            ),
            Container(
              color: rowNumber % 2 == 0
                  ? Colors.white
                  : AppColors.PINK_BACKGROUND_COLOR,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: Row(children: [
                      DesignButton(
                          number: 1, rowNum: rowNumber, isStrongNum: true),
                    ]),
                  ),
                  Container(
                    child: Row(children: [
                      DesignButton(
                          number: 2, rowNum: rowNumber, isStrongNum: true),
                      DesignButton(
                          number: 3, rowNum: rowNumber, isStrongNum: true),
                    ]),
                  ),
                  Container(
                    child: Row(children: [
                      DesignButton(
                          number: 4, rowNum: rowNumber, isStrongNum: true),
                      DesignButton(
                          number: 5, rowNum: rowNumber, isStrongNum: true),
                    ]),
                  ),
                  Container(
                    child: Row(children: [
                      DesignButton(
                          number: 6, rowNum: rowNumber, isStrongNum: true),
                      DesignButton(
                          number: 7, rowNum: rowNumber, isStrongNum: true),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ));
  });
}

class DesignButton extends StatelessWidget {
  final int number;
  final int rowNum;
  final bool isStrongNum;

  const DesignButton(
      {@required this.number,
      @required this.rowNum,
      @required this.isStrongNum});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketProvider>(builder: (context, ticketProvider, child) {
      return Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.only(left: 0, right: 0, top: 3, bottom: 3),
          child: Center(
              child: GestureDetector(
            onTap: () {
              if (isStrongNum == false) {
                ticketProvider.updateTables(rowNum, number - 1);
              } else if (isStrongNum == true) {
                ticketProvider.updateStrongTables(rowNum, number - 1);
              }
            },
            child: Text(
              "$number",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: AppColors.RED_BUTTON_BORDER_COLOR),
            ),
          )),
          height: 19,
          //width: MediaQuery.of(context).size.width / 13,
          width: MediaQuery.of(context).size.width / 13,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.RED_BUTTON_BORDER_COLOR),
              borderRadius: BorderRadius.circular(12),
              color: isStrongNum == true &&
                      ticketProvider.getTablesStrongNumbers(
                              rowNum, number - 1) ==
                          true
                  ? Colors.yellow
                  : (isStrongNum == false &&
                          ticketProvider.getTablesNumbers(rowNum, number - 1) ==
                              true
                      ? Colors.yellow
                      : Colors.white)));
    });
  }
}
