import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctrion {
  static String userlogedinkey = "USERLOGGEDKEY";
  static String userNameKey = "USERNAMEKEY";
  static String useremailkey = "USEREMAILKEY";

  static Future<bool> saveUserLoggedInstatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userlogedinkey, isUserLoggedIn );
  }

  static Future<bool> saveUsersName(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, userName );
  }
  static Future<bool> saveUseremail(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(useremailkey, userEmail );
  }

  static Future<bool?> getUserLogggedinstatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userlogedinkey);
  }
}
