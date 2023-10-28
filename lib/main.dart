import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sosyal_medya/auth/auth.dart';
import 'package:sosyal_medya/auth/giris_veya_kayit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyDzpdQ9b3pP1mBU0KTo7G9QRUceaBDx3Uc",
      appId: "1:845452133674:android:8e7263d224c51a90738a53",
      messagingSenderId: "845452133674",
      projectId: "sosyalmedya-d0205"
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthSayfasi(),
    );
  }
}

