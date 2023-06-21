import 'dart:async';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kamyonetkurye/kontroller/HaritaAyar.dart';
import 'package:kamyonetkurye/main.dart';
import 'package:kamyonetkurye/textekran.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';

class Harita extends StatefulWidget {
  @override
  State<Harita> createState() => _HaritaPageState();
}

class _HaritaPageState extends State<Harita> {
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;
   final kullanici = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TextButton(
            onPressed: () {
              konumEkle();
            },
            child: Text("lokasyonmu ekle")),
        TextButton(
            onPressed: () {
              konumBaslat();
            },
            child: Text("canlı konum başlat")),
        TextButton(
            onPressed: () {
              konumSil();
            },
            child: Text("canlı konum durdur")),
        Expanded(
            child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Konum').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data!.docs[index]['name'].toString()),
                    subtitle: Row(
                      children: [
                        Text(snapshot.data!.docs[index]['latitude'].toString()),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                            snapshot.data!.docs[index]['longitude'].toString()),
                      ],
                    ),
                    trailing: IconButton(
                        icon: Icon(Icons.directions),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  HaritaAyar(snapshot.data!.docs[index].id)));
                        }),
                  );
                });
          },
        ))
      ],
    ));
  }

  konumEkle() async {
    try {
      final loc.LocationData locationReuslt = await location.getLocation();
       Query sorgu = FirebaseFirestore.instance
        .collection('KullaniciBilgi')
        .where("KullaniciId", isEqualTo: kullanici.currentUser!.uid);

      await FirebaseFirestore.instance.collection("Konum").doc('user1').set({
        'latitude': locationReuslt.latitude,
        'longitude': locationReuslt.longitude,
        'name': "mustafa"
      }, SetOptions(merge: true));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> konumBaslat() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((loc.LocationData currentlocation) async {
      await FirebaseFirestore.instance.collection("Konum").doc('user1').set({
        'latitude': currentlocation.latitude,
        'longitude': currentlocation.longitude,
        'name': "mustafa"
      }, SetOptions(merge: true));
    });
  }

  konumSil() {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }
}
