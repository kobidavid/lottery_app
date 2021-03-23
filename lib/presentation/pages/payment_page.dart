import 'package:flutter/material.dart';
import 'package:lottery_app/presentation/state_management/ticket_provider.dart';
import 'package:pdf_render/pdf_render_widgets2.dart';







class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool _isSelected = true;
TicketProvider ticketProvider;

  final controller = PdfViewerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
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
        child: Column(children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: SwitchListTile(
              value: _isSelected,
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected = newValue;
                });
              },
              title: Text(
                'טופס קבוצתי',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          /*RaisedButton(
              color: Colors.red,
              child: Text(
                'שלח',
                style: TextStyle(fontSize: 40),
              ),
              onPressed: () {
                print('send');
                ticketProvider.transferBoolArrayToInt();
              }),*/
          Container(height: 600,
            child: PdfDocumentLoader(
               assetName: 'assets/covid.pdf',
                pageNumber: 1,
                pageBuilder: (context, textureBuilder, pageSize) => textureBuilder()
            ),
          )
        ]),
      ),
    );
  }
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
