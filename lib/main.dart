import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottery_app/domain/entities/ticket.dart';
import 'package:lottery_app/presentation/pages/home_page.dart';
import 'package:lottery_app/presentation/state_management/login_provider.dart';
import 'package:lottery_app/presentation/state_management/ticket_provider.dart';
import 'package:provider/provider.dart';
import 'presentation/pages/double_ticket.dart';
import 'presentation/pages/regular_ticket.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => TicketProvider()),
      Provider(create: (context) => RegularTicket()),

      ChangeNotifierProvider(create: (context) => LoginProvider()),
      Provider(create: (context) => RegularTicket()),
    ],
    child: App(),

  ));

}

class App extends StatelessWidget {
  void initState() {
    //Ticket ticket = Ticket();
  }
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      initialRoute: '/',
      routes: {
      '/':(context)=>HomePage(title: 'לוטו דראעק'),
      '/reg':(context)=>RegularTicket(),
      '/double':(context) =>DoubleTicket()
      },
      debugShowCheckedModeBanner: false,
      //home: HomePage(title: 'לוטו דראק'),
    ));
  }
  }

