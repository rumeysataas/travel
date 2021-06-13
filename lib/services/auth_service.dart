import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/views/home_view.dart';
import 'package:travel/views/login_view.dart';

class AppUser {
  final String? email;
  final String? name;
  final String? uid;

  AppUser({required this.email, required this.name, required this.uid});
}

class AuthService {
  AuthService._privateConstructor();
  static final AuthService _instance = AuthService._privateConstructor();
  static AuthService get instance => _instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  AppUser? currentUser;

  autoLogin() async {
    await _findUser(FirebaseAuth.instance.currentUser);
    RouteManager.newPageReplacement(HomeView());
  }

  logout() {
    FirebaseAuth.instance.signOut();
    RouteManager.newPageReplacement(LoginView());
  }

  signUp(String email, String password, String name) async {
    if (await _controlEmail(email)) {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await _createAccount(userCredential.user, name);
      RouteManager.newPageReplacement(HomeView());
    } else {
      RouteManager.showErrorDialog('Bu e-posta ile kayıt olunulmuş.');
    }
  }

  signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await _findUser(userCredential.user);
      RouteManager.newPageReplacement(HomeView());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        RouteManager.showErrorDialog('Böyle bir kullanıcı Bulamadık');
      } else if (e.code == 'wrong-password') {
        RouteManager.showErrorDialog('Böyle bir kullanıcı Bulamadık');
      }
    }
  }

  Future<bool> _controlEmail(String email) async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('accounts')
        .where('email', isEqualTo: email)
        .get();
    return result.docs.length == 0 ? true : false;
  }

  _createAccount(User? user, String name) async {
    await FirebaseFirestore.instance
        .collection('accounts')
        .doc(user?.uid)
        .set({"email": user?.email, "uid": user?.uid, "name": name});
    currentUser = AppUser(email: user?.email, uid: user?.uid, name: name);
    print(currentUser?.name);
  }

  _findUser(User? user) async {
    final DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('accounts')
        .doc(user?.uid)
        .get();
    currentUser =
        AppUser(email: user?.email, uid: user?.uid, name: result['name']);
  }
}
