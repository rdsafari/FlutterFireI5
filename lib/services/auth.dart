import 'package:ccw/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userLocal(FirebaseUser user, String token) {
    return user != null ? User(uid: user.uid, token: token) : null;
  }

  //stream changes
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userLocal(user, 'token'));
    // .map(_userLocal);
  }

  // sign email & password
  Future signInToFirebase(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser userNew = result.user;
      final idToken = await userNew.getIdToken();
      print(idToken);
      return _userLocal(userNew, idToken.token);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // register email & password
  Future registerEmailToFirebase(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser userNew = result.user;
      final idToken = await userNew.getIdToken();
      return _userLocal(userNew, idToken.token);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // logout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
