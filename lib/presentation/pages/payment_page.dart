import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottery_app/loginF/data/repositories_imp/db_queries_imp.dart';
import 'package:lottery_app/presentation/state_management/ticket_provider.dart';
import 'package:pdf_render/pdf_render_widgets.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isSelected = true;
  late TicketProvider ticketProvider;
  final controller = PdfViewerController();
  DBQueriesImp dbQueriesImp = DBQueriesImp();

  final Color myColor = UniqueColorGenerator.getColor();

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
                          Text((ticketProvider.numOfTables * 3).toString() +
                              " ש\"ח "),
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
                        ticketProvider.numOfTables * 3,
                      );
                    },
                    child: Text("עדכן בסיס נתונים")),
              ]);
            })
          ],
        )));
  }

  Future<DateTime?> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime(2025));

    return picked;
  }
}

class UniqueColorGenerator {
  static Random random = new Random();
  static Color getColor() {
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}
