import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamyonetkurye/sayfalar/icerik/yukumvar.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaPageState();
}

class _AnasayfaPageState extends State<Anasayfa> {
  final List<String> sehirler = [
    " ",
    " Adana",
    "Adıyaman",
    "Afyonkarahisar",
    "Ağrı",
    "Aksaray",
    "Amasya",
    "Ankara",
    "Antalya",
    "Ardahan",
    "Artvin",
    "Aydın",
    "Balıkesir",
    "Bartın",
    "Batman",
    "Bayburt",
    "Bilecik",
    "Bingöl",
    "Bitlis",
    "Bolu",
    "Burdur",
    "Bursa",
    "Çanakkale",
    "Çankırı",
    "Çorum",
    "Denizli",
    "Diyarbakır",
    "Düzce",
    "Edirne",
    "Elazığ",
    "Erzincan",
    "Erzurum",
    "Eskişehir",
    "Gaziantep",
    "Giresun",
    "Gümüşhane",
    "Hakkâri",
    "Hatay",
    "Iğdır",
    "Isparta",
    "İstanbul",
    "İzmir",
    "Kahramanmaraş",
    "Karabük",
    "Karaman",
    "Kars",
    "Kastamonu",
    "Kayseri",
    "Kilis",
    "Kırıkkale",
    "Kırklareli",
    "Kırşehir",
    "Kocaeli",
    "Konya",
    "Kütahya",
    "Malatya",
    "Manisa",
    "Mardin",
    "Mersin",
    "Muğla",
    "Muş",
    "Nevşehir",
    "Niğde",
    "Ordu",
    "Osmaniye",
    "Rize",
    "Sakarya",
    "Samsun",
    "Şanlıurfa",
    "Siirt",
    "Sinop",
    "Sivas",
    "Şırnak",
    "Tekirdağ",
    "Tokat",
    "Trabzon",
    "Tunceli",
    "Uşak",
    "Van",
    "Yalova",
    "Yozgat",
    "Zonguldak",
  ];
  String secilisehir = " ";
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    String ArkaPlan = "assets/images/AnaSayfaust.png";
    return Scaffold(
        backgroundColor: Colors.white, body: Uygulama(height, ArkaPlan));
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                bosluk(),
                Row(
                  children: [YukumIlanButton(), YukumVarButton()],
                ),
                Row(
                  children: [lokasyonButton(), IletisimButton()],
                ),
                Ilanara(),
                YuklemeNoktasi()
              ],
            ),
          )
        ],
      )),
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

  Center YukumIlanButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Container(
          height: 50,
          width: 125,
          decoration: BoxDecoration(color: Color(0xff31274F)),
          child: Center(child: seciliyazi("Yük İlanları", Colors.white)),
        ),
      ),
    );
  }

  Center YukumVarButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) => yukumvar()),
          );
        },
        child: Container(
          height: 50,
          width: 125,
          decoration: BoxDecoration(color: Color(0xff31274F)),
          child: Center(child: seciliyazi("Yüküm Var", Colors.white)),
        ),
      ),
    );
  }

  Center lokasyonButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Container(
          height: 50,
          width: 125,
          decoration: BoxDecoration(color: Color(0xff31274F)),
          child: Center(child: seciliyazi("İletişim", Colors.white)),
        ),
      ),
    );
  }

  Center IletisimButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Container(
          height: 50,
          width: 125,
          decoration: BoxDecoration(color: Color(0xff31274F)),
          child: Center(child: seciliyazi("Lokasyonlar", Colors.white)),
        ),
      ),
    );
  }

  Center YuklemeNoktasi() {
    return Center(
      child: DropdownButton<String>(
        hint: Text("Yükleme Noktası Seciniz",
            style: TextStyle(color: Colors.black)),
        value: secilisehir,
        items: sehirler
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
            .toList(),
        onChanged: (item) => setState(() => item = sehirler.toString()),
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
