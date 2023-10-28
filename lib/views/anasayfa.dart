import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sosyal_medya/views/profil_sayfa.dart';
import 'package:sosyal_medya/yardimci_fonksiyon/yardimci_fonksiyon.dart';
import 'package:sosyal_medya/yardimcilar/drawer.dart';
import 'package:sosyal_medya/yardimcilar/gonderi.dart';
import 'package:sosyal_medya/yardimcilar/text_field.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  final tfController=TextEditingController();

  final currentUser=FirebaseAuth.instance.currentUser!;

  void cikisYap()async{
    await FirebaseAuth.instance.signOut();
  }
  void gonder()async{
    if(tfController.text.isNotEmpty){
      FirebaseFirestore.instance.collection("Gonderiler").add({
        "KullaniciEmail":currentUser.email,
        "Mesaj": tfController.text,
        "TimeStamp": Timestamp.now(),
        "Begenmeler": [],
        "Yorum": [],

      });
    }
    setState(() {
      tfController.clear();
    });
  }

  void profilSayfa(){
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilSayfa()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(title: Text("Social Media",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.orange[900],

      ),
      drawer: MyDrawer(
        onTapProfil: profilSayfa,
        onTapCikisYap: cikisYap,
      ),
      body: Center(
        child: Column(
          children: [

            Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Gonderiler")
                      .orderBy("TimeStamp",descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                        final gonderi=snapshot.data!.docs[index];
                        return Gonderi(
                            mesaj: gonderi["Mesaj"],
                            kullanici: gonderi["KullaniciEmail"],
                            gonderiId: gonderi.id,
                            begenmeler: List<String>.from(gonderi["Begenmeler"] ?? []),
                            zaman: TarihCevir(gonderi["TimeStamp"],),
                            yorumlar: List<String>.from(gonderi["Yorum"] ?? []),
                        );
                      });
                    }else if (snapshot.hasError){
                      return Center(child: Text("Hata: ${snapshot.hasError}"),);
                    }
                    return Center(child: CircularProgressIndicator(),);
                  },
                )),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(child: MyTextField(
                      controller: tfController,
                      hintText: "Gönderiniz için bir şeyler yazın",
                      obscureText: false)
                  ),
                  IconButton(onPressed: gonder, icon: Icon(Icons.send,color: Colors.black,)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Text("Kullanıcı: ${currentUser.email!}",style: TextStyle(color: Colors.grey[700]),),
            ),
          ],
        ),
      ),

    );
  }
}
