import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottery_app/loginF/data/repositories_imp/db_queries_imp.dart';
import 'package:lottery_app/presentation/state_management/ticket_provider.dart';
import 'package:pdf_render/pdf_render_widgets2.dart';
import 'package:provider/provider.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:io';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isSelected = true;
  TicketProvider ticketProvider;
  String text = "";
  String kkk = "s";
  final controller = PdfViewerController();
  DBQueriesImp dbQueriesImp = DBQueriesImp();

  final Color myColor = UniqueColorGenerator.getColor();

  Future<HttpClientResponse> _sendOTP() async {
    var builder = new xml.XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="iso-8859-9"');
    builder.element('MainmsgBody', nest: () {
      builder.element('PassWord', nest: "yyyyyyyy");
      builder.element('Action', nest: 5);
      builder.element('Mesgbody', nest: "I am Fluttering with Dart");
      builder.element('Numbers', nest: 5);
    });
    var bookshelfXml = builder.build();
    String _uriMsj = bookshelfXml.toString();
    print("_uriMsj: $_uriMsj");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Color myColor = UniqueColorGenerator.getColor();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('דף תשלום'),
          actions: [
            IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  _pickDate(context).then((value) => print(value));
                })
          ],
        ),
        body: Container(
            //child: Center(child: Text(TicketProvider.type=='regular'?(TicketProvider.currentNumOnRow*2+2).toString():'Not Reg')),
            child: Column(
          children: [
            Consumer<TicketProvider>(builder: (context, ticketProvider, child) {
              return Column(children: [
                Text(
                  "מספר טבלאות: " + ticketProvider.numOfTables.toString(),
                  style: TextStyle(fontSize: 24),
                ),
                Directionality(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("סכום לתשלום: "),
                          Text((ticketProvider.numOfTables*3).toString()+" ש\"ח "),
                        ],
                      ),
                    ),
                    textDirection: TextDirection.rtl),
                TextButton(
                    onPressed: () {
                      dbQueriesImp.findUserDoc(
                          TicketProvider.myIntList,
                          TicketProvider.myIntStrongList,
                          TicketProvider.currentNumOnTables,
                         ticketProvider.numOfTables*3,
                      );
                    },
                    child: Text("עדכן בסיס נתונים")),
                AutoDirection(
                  text: text,
                  child: TextField(
                    onChanged: (str) {
                      setState(() {
                        text = str;
                      });
                    },
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.end,
                      text: TextSpan(
                        //text: 'Hello ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.black),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'אופק',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15,color:myColor )),
                          TextSpan(text: ' sdsdjsk'),
                        ],
                      ),
                    ),
                  ],
                ),
                ProgressButton(
                  //normalWidget: const Text('I am a button'),
                  progressWidget: const CircularProgressIndicator(),
                  color: Colors.red,

                  width: 196,
                  height: 40,
                  onPressed: () async {
                    int score = await Future.delayed(
                        const Duration(milliseconds: 3000), () => 42);
                    // After [onPressed], it will trigger animation running backwards, from end to beginning
                    return () {
                      // Optional returns is returning a VoidCallback that will be called
                      // after the animation is stopped at the beginning.
                      // A best practice would be to do time-consuming task in [onPressed],
                      // and do page navigation in the returned VoidCallback.
                      // So that user won't missed out the reverse animation.
                    };
                  },
                ),
                Container(key:Key('123'),
              child:  Text("lll"))
              ]);
            })
          ],
        )));
  }

  Future<DateTime> _pickDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2025));
    if (picked != null) {
      return picked;
    }
  }
}
class UniqueColorGenerator {
  static Random random = new Random();
  static Color getColor() {
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}