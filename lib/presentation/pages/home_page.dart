import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottery_app/core/service_locator.dart';
import 'package:lottery_app/core/shared_preferences_names.dart';
import 'package:lottery_app/domain/entities/spEntity.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';
import 'package:lottery_app/loginF/data/repositories_imp/db_queries_imp.dart';
import 'package:lottery_app/loginF/presentation/state_management/login_provider.dart';
import 'package:lottery_app/loginF/presentation/state_management/register_provider.dart';
import 'package:lottery_app/presentation/pages/regular_ticket.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  final String title;
  final FirebaseAuth auth = FirebaseAuth.instance;
  GetIt getIt = GetIt.instance;
  GoogleSignIn googleSignIn=GoogleSignIn();

  DBQueriesImp dbQueriesImp=DBQueriesImp();
  //LoginProvider uName=Provider.of<SharedPreferenceName.>(context);
  HomePage({@required this.title});

  void setup() {
    getIt.registerSingleton<UserEntity>(UserEntity());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //shadowColor: Colors.white,
        centerTitle: true,
        backgroundColor: Colors.transparent,

        leading:
        Consumer<LoginProvider>(builder: (BuildContext context,loginProvider,child){
              return auth.currentUser!=null?CircleAvatar(
            radius: 9.0,
            child: Text(loginProvider.uNameForIcon)):Text("");}),
            //child: Text("kobi")):Text("");}),

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          )
        ],
        title: Text(title,
            style: GoogleFonts.gabriela(
                color: Colors.black,
                fontSize: 44,
                fontWeight: FontWeight.bold)),

        elevation: 0,
        //shape: AnimationController(),
        // shadowColor: Colors.orange,
      ),
      body: Column(
        children: [
          new Container(
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
                child: Center(
                    child: Column(
              children: [
                Text(
                  "",
                  style: GoogleFonts.secularOne(
                      fontSize: 22, fontWeight: FontWeight.w700),
                ),
                // Text(userState()==true?auth.currentUser.email:""),
                //Text(loginProvider.userEmail ?? "kkdd"),
                //Text(auth.signInWithCredential(credential).),
                //Text(userState()!=null?auth.currentUser.email:""),
                GestureDetector(
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Provider.of<LoginProvider>(context,listen: false).logOutUser();
                    //auth.signOut();
                    //googleSignIn.disconnect();

                  },
                ),
                /*GestureDetector(
                  child: Text(
                    "delete spref",
                    style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    //prefs.remove("isRegister");
                    //prefs.setBool(IS_REGISTERED, false);
                    await prefs.clear();
                    print("prefs.clear()");
                  },
                ),*/
              ],
            ))),
            height: 170.0,
            /* decoration: new BoxDecoration(
              color: Color(0xffe678ff),
              boxShadow: [new BoxShadow(blurRadius: 20.0)],
              borderRadius: new BorderRadius.vertical(
                  bottom: new Radius.elliptical(
                      MediaQuery.of(context).size.width, 100.0)),
            ),*/
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView(
              children: <Widget>[
                Card(
                  color: Colors.tealAccent,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RegularTicket(),
                        ),
                      );
                    },
                    //leading: Icon(Icons.more_vert),
                    title: Text(
                      'טופס רגיל',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 30),
                    ),
                    subtitle: Text(
                      ' פרס ראשון 15 מיליון ש״ח',
                      textDirection: TextDirection.rtl,
                    ),
                    trailing: FlutterLogo(size: 80.0),
                    isThreeLine: true,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  color: Colors.tealAccent,
                  child: ListTile(
                    //onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => DoubleTicket()));},
                    onTap: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                                email: "barry.allen@example6.com",
                                password: "SuperSecretPassword6!");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    //leading: Icon(Icons.more_vert),
                    title: Text(
                      'טופס דאבל',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 30),
                    ),
                    subtitle: Text(
                      'פרס ראשון עד 40 מיליון ש״ח',
                      textDirection: TextDirection.rtl,
                    ),
                    trailing: FlutterLogo(size: 80.0),
                    isThreeLine: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool userState() {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        return false;
      }
    });
    return true;
  }

  Future<String> getSPuserNameValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool userIsLoggedIn = prefs.getBool(IS_LOGIN);
    if (userIsLoggedIn == true) {
      return prefs.getString(USER_NAME);
    }
    return null;
  }
}
