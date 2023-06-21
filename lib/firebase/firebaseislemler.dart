import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class islemler {
  final firebaseislemler = FirebaseAuth.instance;

  Future girisislemi(String eposta, String sifre) async {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: eposta, password: sifre);
  }
}
