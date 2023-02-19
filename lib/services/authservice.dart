import 'package:backslah_chat_app/helper/helper_function.dart';
import 'package:backslah_chat_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future registerUserWithemailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        await DatabaseServices(uid: user.uid).updateUserData(fullName, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      return e;
    }
  }

  Future signout() async {
    try {
      await HelperFunctrion.saveUserLoggedInstatus(false);
      await HelperFunctrion.saveUseremail('');
      await HelperFunctrion.saveUsersName('');
      firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
