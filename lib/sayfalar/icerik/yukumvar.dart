import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:kamyonetkurye/textekran.dart';

class yukumvar extends StatefulWidget {
  const yukumvar({Key? key}) : super(key: key);

  @override
  State<yukumvar> createState() => _yukumvarPageState();
}

class _yukumvarPageState extends State<yukumvar> {
  late String aractipi,
      kiralamatipi,
      aracozellik,
      donanim,
      tarih,
      yuklemeadres,
      bosaltmaadres,
      yukcins,
      yuktanim,
      yuklemesekli,
      odemesekli;
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
          bosluk(),
          Text(
            "Araç Özelikleri",
            style: TextStyle(inherit: true, fontSize: 25),
          ),
          Text("Araç Tipi"),
          cizgi(),
          bosluk(),
          grupbutton(
              ["Penalvan", "Kamyon", "Tır", "OrtaBoy", "Kamyonet", "Boş"],
              75,
              100),
          bosluk(),
          Text(
            "Arac Kiralama Tipi",
            style: TextStyle(inherit: true),
          ),
          cizgi(),
          bosluk(),
          grupbutton(["Komple Araç", "Parsiyel"], 75, 150),
          bosluk(),
          Text(
            "Araç Özellikleri",
            style: TextStyle(inherit: true),
          ),
          cizgi(),
          bosluk(),
          YuklemeNoktasi(["Soğutmalı", "Isıtmalı"], "Isıtmalı"),
        ],
      )),
    );
  }

  Center grupbutton(List<String> degerler, double yukseklik, double genislik) {
    return Center(
      child: GroupButton(
        isRadio: true,
        onSelected: ((value, index, isSelected) =>
            print('$value button is selected')),
        buttons: degerler,
        options: GroupButtonOptions(
          unselectedColor: Color(0xff21254A),
          selectedColor: Color(0xff21254A),
          selectedTextStyle: TextStyle(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
          buttonHeight: yukseklik,
          buttonWidth: genislik,
        ),
      ),
    );
  }

  Center YuklemeNoktasi(List<String> elemanlar, String dropdownValue) {
    return Center(
      child: Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(border: Border.all(color: Color(0xff771FE7))),
        child: DropdownButton<String>(
          value: dropdownValue,
          items: elemanlar.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue ?? '';
            });
          },
        ),
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

  TextFormField Ilanara() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration:
          InputDecoration(suffixIcon: Icon(Icons.search), hintText: "İlan Ara"),
    );
  }

  Image cizgi() {
    return Image.asset("assets/images/Cizgi.png");
  }

  Widget bosluk() => SizedBox(height: 25);
  Widget boslukyatay() => SizedBox(width: 5);

  Widget seciliyazi(
    String text,
    Color color,
  ) =>
      Text(
        text,
        style: TextStyle(
          color: color,
        ),
      );
}
