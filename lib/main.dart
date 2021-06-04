import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottery_app/core/di/di.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';
import 'package:lottery_app/presentation/pages/home_page.dart';
import 'package:lottery_app/loginF/presentation/state_management/login_provider.dart';
import 'package:lottery_app/loginF/presentation/state_management/register_provider.dart';
import 'package:lottery_app/presentation/state_management/ticket_provider.dart';
import 'package:lottery_app/services/sp_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/service_locator.dart';
import 'presentation/pages/double_ticket.dart';
import 'presentation/pages/regular_ticket.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  //getIt.registerSingleton<UserEntity>(UserEntity(), signalsReady: true);

  var x = LoginProvider();
  FirebaseAuth _auth;
  //if (_auth != null) {
    await x.userNameForIcon();
  //}

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginProvider>(create: (_) => x),
      ChangeNotifierProvider<TicketProvider>(create: (_) => TicketProvider()),
      ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider()),
    ],
    child: App(),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      // do whatever you want based on the firebaseUser state
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
      ),
      darkTheme:
          ThemeData(brightness: Brightness.light, primarySwatch: Colors.red),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(title: 'לוטו דראעק'),
        '/reg': (context) => RegularTicket(),
        '/double': (context) => DoubleTicket(),
      },
      //home: HomePage(title: 'לוטו דראק'),
    );
  }
}
