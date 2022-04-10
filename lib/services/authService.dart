import 'package:PtCO2/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function that creates a user object based on User
  App_User? _userFromUser(User user) {
    return user != null ? App_User(uid: user.uid) : null;
  }

  // Authentication change user stream
  Stream<App_User?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromUser(user!));
  }

  // Sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
