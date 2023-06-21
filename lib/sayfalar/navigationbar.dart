import 'package:flutter/material.dart';
import 'package:kamyonetkurye/sayfalar/icerik/anasayfa.dart';
import 'package:kamyonetkurye/sayfalar/icerik/bilgilerim.dart';
import 'package:kamyonetkurye/sayfalar/icerik/harita.dart';

class navigationPage extends StatefulWidget {
  const navigationPage({Key? key}) : super(key: key);

  @override
  State<navigationPage> createState() => _navigationPageState();
}

class _navigationPageState extends State<navigationPage> {
  int secilisayfa = 0;
  final screens = [
    Anasayfa(),
    Harita(),
    Anasayfa(),
    Anasayfa(),
    Bilgilerim(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: screens[secilisayfa],
        bottomNavigationBar: BottomNavigationBar(           
            currentIndex: secilisayfa,
            onTap: (index) => setState(() => secilisayfa = index),
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/home.png",
                    height: 24,
                    width: 24,
                  ),
                  label: "Ana Sayfa",
                  backgroundColor: Colors.cyan),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/map.png",
                    height: 24,
                    width: 24,
                  ),
                  label: "Harita",
                  backgroundColor: Colors.green),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/araba.png",
                    height: 50,
                    width: 50,
                  ),
                  label: "Kamyonet\n\t\tÇağır",
                  backgroundColor: Colors.black),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/buyutec.png",
                    height: 24,
                    width: 24,
                  ),
                  label: "Sorgula",
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/images/person.png",
                    height: 24,
                    width: 24,
                  ),
                  label: "Bilgilerim",
                  backgroundColor: Colors.orange),
            ]),
      );
}
