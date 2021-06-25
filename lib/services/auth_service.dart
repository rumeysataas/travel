import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel/core/router_manager.dart';
import 'package:travel/views/home_view.dart';
import 'package:travel/views/login_view.dart';

//kullanıcı bilgilerini tutan modelimiz
class AppUser {
  final String? email;
  final String? name;
  final String? uid;
  String? profilePhoto;

  AppUser(
      {required this.email,
      required this.name,
      required this.uid,
      required this.profilePhoto});
}

//giriş işlemlerini yapacağımız sınıfımız
class AuthService {
  AuthService._privateConstructor();
  static final AuthService _instance = AuthService._privateConstructor();
  static AuthService get instance => _instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  AppUser? currentUser;

  autoLogin() async {                                   //otomatik olarak giriş yap eğer kullanıcı varsa
    await _findUser(FirebaseAuth.instance.currentUser);
    RouteManager.newPageReplacement(HomeView());
  }

  logout() {                                        //çıkış yap ve giriş sayfasına yönlendir
    FirebaseAuth.instance.signOut();
    RouteManager.newPageReplacement(LoginView());
  }

  signUp(String email, String password, String name) async {    //kayıt ol
    if (await _controlEmail(email)) {                           //eğer önceki kayıttaki emailden yoksa
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await _createAccount(userCredential.user, name);
      RouteManager.newPageReplacement(HomeView());
    } else {                                                 //email varsa hata göster
      RouteManager.showErrorDialog('Bu e-posta ile kayıt olunmuş.');
    }
  }

  signIn(String email, String password) async {     //giriş
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await _findUser(userCredential.user);
      RouteManager.newPageReplacement(HomeView());      //kullanıcı bilgileri doğru olduğu taktirde giriş yap
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        RouteManager.showErrorDialog('Böyle bir kullanıcı Bulamadık');   //yoksa hata göster
      } else if (e.code == 'wrong-password') {
        RouteManager.showErrorDialog('Böyle bir kullanıcı Bulamadık');
      }
    }
  }

  Future<bool> _controlEmail(String email) async {               //e-posta adresini kontrol et eğer varsa true yoksa false dön
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection('accounts')
        .where('email', isEqualTo: email)
        .get();
    return result.docs.length == 0 ? true : false;
  }

  newProfilePhoto(String path) async {        //profil fotoğrafı yükle
    try {
      await FirebaseFirestore.instance
          .collection('accounts')   //veritabanımız
          .doc(currentUser?.uid)      //yükleyen kullanıcının idsi
          .update({"profilePhoto": path});
      currentUser?.profilePhoto = path;
      RouteManager.showCustomDialog('Profil fotoğrafınız değiştirildi. 🖼', [
        ElevatedButton(
            onPressed: () {
              RouteManager.newPageReplacement(HomeView());
            },
            child: Text('Tamam '))
      ]);
    } catch (e) {
      print(e);
      RouteManager.showErrorDialog(
          'Beklenmedik bir hata oluştu. Lütfen tekrar deneyin?');
    }
  }

  _createAccount(User? user, String name) async {                                 //yeni hesap oluştur
    await FirebaseFirestore.instance.collection('accounts').doc(user?.uid).set({
      "email": user?.email,
      "uid": user?.uid,
      "name": name,
      "profilePhoto": "na"                        //profil fotoğrafı varsayılan olarak yok
    });
    currentUser = AppUser(
        email: user?.email, uid: user?.uid, name: name, profilePhoto: "na");
    print(currentUser?.name);
  }

  _findUser(User? user) async {
    final DocumentSnapshot result = await FirebaseFirestore.instance
        .collection('accounts')
        .doc(user?.uid)
        .get();
    currentUser = AppUser(        //kullanıcıyı bul ve kayıt et
        email: user?.email,
        uid: user?.uid,
        name: result['name'],
        profilePhoto: result['profilePhoto']);
  }
}
