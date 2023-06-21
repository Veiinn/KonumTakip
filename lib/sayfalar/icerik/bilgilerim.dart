import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kamyonetkurye/textekran.dart';

class Bilgilerim extends StatefulWidget {
  const Bilgilerim({Key? key}) : super(key: key);

  @override
  State<Bilgilerim> createState() => _BilgilerimPageState();
}

class _BilgilerimPageState extends State<Bilgilerim> {
  late String Ad, Soyad, Telefon, Email;
  final formkey = GlobalKey<FormState>();
  final kullanici = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    String ArkaPlan = "assets/images/AnaSayfaust.png";
    return Scaffold(body: Uygulama(height, ArkaPlan));
  }

  SingleChildScrollView Uygulama(double height, String ArkaPlan) {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bosluk(),
          ArkaPlanContainer(height, ArkaPlan),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    bilgiler(),
                    Guncellebutton(),
                  ],
                )),
          )
        ],
      )),
    );
  }

  StreamBuilder bilgiler() {
    TextEditingController Kontrol1 = new TextEditingController();
    TextEditingController Kontrol2 = new TextEditingController();
    TextEditingController Kontrol3 = new TextEditingController();
    TextEditingController Kontrol4 = new TextEditingController();
    Query sorgu = FirebaseFirestore.instance
        .collection('KullaniciBilgi')
        .where("KullaniciId", isEqualTo: kullanici.currentUser!.uid);

    return StreamBuilder<QuerySnapshot>(
      stream: sorgu.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            Kontrol1.text = '${data['KullaniciAd']}';
            Kontrol2.text = '${data['KullaniciSoyad']}';
            Kontrol3.text = '${data['KullaniciEmail']}';
            Kontrol4.text = '${data['KullaniciTelefon']}';
            return Column(
              children: [
                TextFormField(
                  controller: Kontrol1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Bilgileri Eksizsiz Doldurunuz";
                    } else {}
                  },
                  onSaved: (value) {
                    Ad = value!;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white)),
                ),
                TextFormField(
                  controller: Kontrol2,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Bilgileri Eksizsiz Doldurunuz";
                    } else {}
                  },
                  onSaved: (value) {
                    Soyad = value!;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white)),
                ),
                TextFormField(
                  controller: Kontrol3,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Bilgileri Eksizsiz Doldurunuz";
                    } else {}
                  },
                  onSaved: (value) {
                    Email = value!;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white)),
                ),
                TextFormField(
                  controller: Kontrol4,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Bilgileri Eksizsiz Doldurunuz";
                    } else {}
                  },
                  onSaved: (value) {
                    Telefon = value!;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white)),
                ),
              ],
            );
          }).toList(),
          shrinkWrap: true,
        );
      },
    );
  }

  Center Guncellebutton() {
    return Center(
      child: TextButton(
        onPressed: GuncellemeIslemleri,
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

  void GuncellemeIslemleri() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      try {
        {
          FirebaseFirestore.instance
              .collection('KullaniciBilgi')
              .where('KullaniciId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((value) {
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection("KullaniciBilgi")
                  .doc(element.id)
                  .update({
                'KullaniciAd': Ad,
                'KullaniciSoyad': Soyad,
                'KullaniciEmail': Email,
                'KullaniciTelefon': Telefon,
              });
            });
          });
          // FirebaseFirestore.instance
          //     .collection("KullaniciBilgi")
          //     .doc(Ad + " " + Soyad)
          //     .update({
          //   'KullaniciAd': Ad,
          //   'KullaniciSoyad': Soyad,
          //   'KullaniciEmail': Email,
          //   'KullaniciTelefon': Telefon,
          // });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Bilgileriniz başarılı bir şekilde güncellenmiştir"),
          ),
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

  TextFormField Ilanara() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration:
          InputDecoration(suffixIcon: Icon(Icons.search), hintText: "İlan Ara"),
    );
  }

  Widget bosluk() => SizedBox(height: 25);

  Widget seciliyazi(String text, Color color) => Text(
        text,
        style: TextStyle(color: color),
      );
}
