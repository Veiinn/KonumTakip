import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kamyonetkurye/sayfalar/girissayfa.dart';
import 'package:kamyonetkurye/kontroller/dil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(), // your translations
      locale:
          Locale('tr', 'TR'), // translations will be displayed in that locale
      fallbackLocale: Locale('tr',
          'TR'), // specify the fallback locale in case an invalid locale is selected.
      home: Center(child: Giris()),
    );
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
