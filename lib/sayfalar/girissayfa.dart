import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kamyonetkurye/sayfalar/icerik/anasayfa.dart';
import 'package:kamyonetkurye/sayfalar/navigationbar.dart';
import 'package:kamyonetkurye/sayfalar/uyeolsayfa.dart';
import 'package:get/get.dart';

class Giris extends StatefulWidget {
  @override
  State<Giris> createState() => _GirisPageState();
}

class _GirisPageState extends State<Giris> {
  late String email, sifre;
  final formkey = GlobalKey<FormState>();
  final firebaseauth = FirebaseAuth.instance;
  String secim = "Türkçe";
  String TurkceGiris = "assets/images/GirisButonTr.png";
  String IngilizceGiris = "assets/images/GirisButonEn.png";
  String button = "assets/images/GirisButonTr.png";
  @override
  Widget build(BuildContext context) {
    String secilidil = "";
    var height = MediaQuery.of(context).size.height;
    String ArkaPlan = "assets/images/ArkaPlan.png";
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
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        baslik(),
                      ],
                    ),
                    bosluk(),
                    EpostaTextFiled(),
                    bosluk(),
                    SifreTextField(),
                    Row(
                      children: [SifremiUnuttumButton(), KayitOl()],
                    ),
                    bosluk(),
                    girisbutton(),
                    DilSec(),
                  ],
                )),
          )
        ],
      )),
    );
  }

  Text baslik() {
    return Text(
      "KAMYONET\nKURYE\'YE\nHOŞGELDİN !".tr,
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
        email = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: "E-Posta".tr, hintStyle: TextStyle(color: Colors.white)),
    );
  }

  TextFormField SifreTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz".tr;
        } else {}
      },
      onSaved: (value) {
        sifre = value!;
      },
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          hintText: 'Şifre'.tr, hintStyle: TextStyle(color: Colors.white)),
    );
  }

  Center girisbutton() {
    return Center(
      child: TextButton(
        onPressed: GirisIslemleri,
        child: Container(
          height: 75,
          width: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(button),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  void GirisIslemleri() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      try {
        final Kullanici = await firebaseauth.signInWithEmailAndPassword(
            email: email, password: sifre);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => navigationPage()),
            (r) => false);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Center SifremiUnuttumButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Container(
          height: 25,
          width: 130,
          decoration: BoxDecoration(color: Color(0xff31274F)),
          child: Center(child: seciliyazi("Şifremi Unuttum", Colors.white)),
        ),
      ),
    );
  }

  Center KayitOl() {
    return Center(
        child: TextButton(
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Uyeol(
                    dil: secim,
                  ))),
      child: Container(
        height: 25,
        width: 130,
        decoration: BoxDecoration(color: Color(0xff31274F)),
        child: Center(child: seciliyazi("Hesap Oluştur", Colors.white)),
      ),
    ));
  }

  Center DilSec() {
    return Center(
      child: DropdownButton<String>(
        hint: Text("Dil Değiştir".tr, style: TextStyle(color: Colors.white)),
        disabledHint: Text("Dil Seç"),
        dropdownColor: Color(0xff21254A),
        items: [
          DropdownMenuItem(
              child: Text("Türkçe".tr, style: TextStyle(color: Colors.white)),
              value: "Türkçe",
              onTap: (() {
                Get.updateLocale(Locale("tr", "TR"));
                button = TurkceGiris;
              })),
          DropdownMenuItem(
              child:
                  Text("İngilizce".tr, style: TextStyle(color: Colors.white)),
              value: "İngilizce",
              onTap: (() {
                Get.updateLocale(Locale("en", "US"));
                button = IngilizceGiris;
              }))
        ],
        onChanged: ((value) {
          setState(() {
            secim = value.toString();
          });
        }),
      ),
    );
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

  Widget bosluk() => SizedBox(
        height: 20,
      );
  Widget seciliyazi(String text, Color color) => Text(
        text.tr,
        style: TextStyle(color: color),
      );
}
