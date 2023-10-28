import 'package:flutter/material.dart';
import 'package:sosyal_medya/views/kayit_ol.dart';

import '../views/giris_yap.dart';

class GirisVeyaKayit extends StatefulWidget {
  const GirisVeyaKayit({super.key});

  @override
  State<GirisVeyaKayit> createState() => _GirisVeyaKayitState();
}

class _GirisVeyaKayitState extends State<GirisVeyaKayit> {

  bool girisEkraniGoster=true;

  void sayfaGecisi(){
    setState(() {
      girisEkraniGoster=!girisEkraniGoster;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(girisEkraniGoster){
      return GirisYap(onTap: sayfaGecisi);
    }else{
      return KayitOl(onTap: sayfaGecisi);
    }
  }
}
