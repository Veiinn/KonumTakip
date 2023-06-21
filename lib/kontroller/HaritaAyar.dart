import 'dart:async';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kamyonetkurye/main.dart';
import 'package:kamyonetkurye/textekran.dart';
import 'package:location/location.dart' as loc;

class HaritaAyar extends StatefulWidget {
  late final String user_id;
  HaritaAyar(this.user_id);
  @override
  State<HaritaAyar> createState() => _HaritaAyarPageState();
}

class _HaritaAyarPageState extends State<HaritaAyar> {
  final loc.Location location = loc.Location();
  late GoogleMapController _controller;
  bool _added = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Konum').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (_added) {
          haritam(snapshot);
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return GoogleMap(
            mapType: MapType.normal,
            markers: {
              Marker(position: LatLng(
                    snapshot.data!.docs.singleWhere(
                        (element) => element.id == widget.user_id)['latitude'],
                    snapshot.data!.docs.singleWhere((element) =>
                        element.id == widget.user_id)['longitude']),
                  markerId: MarkerId('id'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueBlue))
            },
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    snapshot.data!.docs.singleWhere(
                        (element) => element.id == widget.user_id)['latitude'],
                    snapshot.data!.docs.singleWhere((element) =>
                        element.id == widget.user_id)['longitude']),
                zoom: 15.47),
            onMapCreated: (GoogleMapController controller) async {
              setState(() {
                _controller = controller;
                _added = true;
              });
            });
      },
    ));
  }

  Future<void> haritam(AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.user_id)['latitude'],
                snapshot.data!.docs.singleWhere(
                    (element) => element.id == widget.user_id)['longitude']),
            zoom: 15.47)));
  }
}
