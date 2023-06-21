import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kamyonetkurye/sayfalar/girissayfa.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:get/get.dart';
import 'package:kamyonetkurye/sayfalar/girissayfa.dart';

class Uyeol extends StatefulWidget {
  String dil = "";
  Uyeol({required this.dil});

  @override
  State<Uyeol> createState() => _UyeolPageState();
}

class _UyeolPageState extends State<Uyeol> {
  late String Ad, Soyad, Telefon, Email, Sifre;
  final formkey = GlobalKey<FormState>();
  final firebaseauth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    String ArkaPlan = "assets/images/ArkaPlan.png";

    Future<bool> rebuild() async {
      if (!mounted) return false;
      setState(() {
        Get.updateLocale(Locale('en', 'US'));
      });
      return true;
    }

    return Scaffold(
      backgroundColor: Color(0xff21254A),
      body: uygulama(height, ArkaPlan),
    );
  }

  SingleChildScrollView uygulama(double height, String ArkaPlan) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArkaPlanContainer(height, ArkaPlan),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    bosluk(),
                    baslik(),
                    bosluk(),
                    AdTextFiled(),
                    SoyadTextFiled(),
                    EpostaTextFiled(),
                    TelNoTextFiled(),
                    SifreTextField(),
                    KayitOlbutton(),
                    HesabimvarButton(),
                  ],
                )),
          )
        ],
      )),
    );
  }

  Center baslik() {
    return Center(
      child: Container(
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/UyeolUst.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  TextFormField AdTextFiled() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz".tr;
        } else {}
      },
      onSaved: (value) {
        Ad = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: "İsim".tr, hintStyle: TextStyle(color: Colors.white)),
    );
  }

  TextFormField SoyadTextFiled() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz".tr;
        } else {}
      },
      onSaved: (value) {
        Soyad = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: "Soyad".tr, hintStyle: TextStyle(color: Colors.white)),
    );
  }

  TextFormField EpostaTextFiled() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz".tr;
        } else {}
      },
      onSaved: (value) {
        Email = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: "E-Posta".tr, hintStyle: TextStyle(color: Colors.white)),
    );
  }

  TextFormField TelNoTextFiled() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz".tr;
        } else {}
      },
      onSaved: (value) {
        Telefon = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: "Telefon".tr, hintStyle: TextStyle(color: Colors.white)),
      keyboardType: TextInputType.phone,
      autocorrect: false,
      inputFormatters: [MaskedInputFormatter('(000)000-00-00')],
    );
  }

  TextFormField SifreTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksizsiz Doldurunuz".tr;
        } else {}
      },
      onSaved: (value) {
        Sifre = value!;
      },
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: 'Şifre'.tr, hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Center KayitOlbutton() {
    return Center(
      child: TextButton(
        onPressed: KayitIslemleri,
        child: Container(
          height: 75,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/UyeOlButon.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void KayitIslemleri() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      try {
        var kullanici = await firebaseauth
            .createUserWithEmailAndPassword(email: Email, password: Sifre)
            .then((KullaniciBilgi) {
          FirebaseFirestore.instance
              .collection("KullaniciBilgi")
              .doc(Ad + " " + Soyad)
              .set({
            'KullaniciId': KullaniciBilgi.user!.uid,
            'KullaniciAd': Ad,
            'KullaniciSoyad': Soyad,
            'KullaniciEmail': Email,
            'KullaniciTelefon': Telefon,
            'KullaniciSifre': Sifre,
          });
        });
        formkey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text("Kayıt Başarılı, Giriş Sayfasına Yönlendiriliyorsunuz"),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Giris()),
        );
      } catch (e) {
        print(e.toString());
      }
    } else {}
  }

  Container ArkaPlanContainer(double height, String ArkaPlan) {
    return Container(
      height: height * .30,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(ArkaPlan),
        ),
      ),
    );
  }

  Center HesabimvarButton() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Giris())),
        child: Container(
          height: 25,
          width: 170,
          decoration: BoxDecoration(color: Color(0xff31274F)),
          child:
              Center(child: seciliyazi("Zaten Hesabım Var".tr, Colors.white)),
        ),
      ),
    );
  }

  Widget bosluk() => SizedBox(
        height: 20,
      );
  Widget seciliyazi(String text, Color color) => Text(
        text,
        style: TextStyle(color: color),
      );
}
