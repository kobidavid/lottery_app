import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottery_app/domain/entities/user_entity.dart';
import 'package:lottery_app/presentation/pages/regular_ticket.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottery_app/presentation/state_management/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
class HomePage extends StatelessWidget {
  final String title;
  final FirebaseAuth auth = FirebaseAuth.instance;
  GetIt getIt =GetIt.instance;
  HomePage({@required this.title});
  void setup() {
    getIt.registerSingleton<UserEntity>(UserEntity());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*  appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(title),
        elevation: 6,
        //shape: AnimationController(),
        shadowColor: Colors.orange,
      ),*/
      body: Column(
        children: [
          new Container(
            width: MediaQuery.of(context).size.width,
            child: SafeArea(child: Consumer<LoginProvider>(
                builder: (context, loginProvider, _) {
                  return Center(
                      child: Column(
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.secularOne(
                            fontSize: 22, fontWeight: FontWeight.w700),
                      ),
                      // Text(userState()==true?auth.currentUser.email:""),
                      Text(loginProvider.userEmail ?? "kkdd"),
                      //Text(auth.signInWithCredential(credential).),
                      //Text(userState()!=null?auth.currentUser.email:""),
                      GestureDetector(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () async {
                          //SharedPreferences prefs = await SharedPreferences.getInstance();
                          //prefs.setBool('isRegister', true);
                          loginProvider.logOutUser();
                        },
                      ),
                      GestureDetector(
                        child: Text(
                          "delete spref",
                          style: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: ()  async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove("isRegister");

                        },
                      ),
                    ],
                  ));

            })),
            height: 170.0,
            decoration: new BoxDecoration(
              color: Color(0xffe678ff),
              boxShadow: [new BoxShadow(blurRadius: 20.0)],
              borderRadius: new BorderRadius.vertical(
                  bottom: new Radius.elliptical(
                      MediaQuery.of(context).size.width, 100.0)),
            ),
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
                      Navigator.push(
                        context,
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
}
