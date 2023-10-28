import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sosyal_medya/auth/giris_veya_kayit.dart';
import 'package:sosyal_medya/views/anasayfa.dart';

class AuthSayfasi extends StatelessWidget {
  const AuthSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Anasayfa();
          }else{
            return GirisVeyaKayit();
          }
        },
      ),
    );
  }
}
