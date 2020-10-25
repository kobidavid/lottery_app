import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  @override
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
      body: Container(),
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
