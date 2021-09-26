import 'package:lottery_app/core/shared_preferences_names.dart';
import 'package:lottery_app/domain/entities/spEntity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  late SharedPreferenceName sharedPreferenceName;

  Future<String?> get getSPuserNameValue async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? userIsLoggedIn = prefs.getBool(IS_LOGIN);
    //prefs.setBool(IS_LOGIN, true);
    if (userIsLoggedIn == true) {
      //final myName= prefs.getString(USER_NAME);
      final myName = prefs.getString(USER_NAME);
      return myName;
    }
    final myName = "";
    return myName;
  }
}
