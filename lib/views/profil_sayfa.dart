import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sosyal_medya/yardimcilar/text.dart';

class ProfilSayfa extends StatefulWidget {
  const ProfilSayfa({super.key});

  @override
  State<ProfilSayfa> createState() => _ProfilSayfaState();
}

class _ProfilSayfaState extends State<ProfilSayfa> {

  final currentUser=FirebaseAuth.instance.currentUser!;
  final usersCollection=FirebaseFirestore.instance.collection("Kullanicilar");

  Future<void> ayarlariDuzenle(String deger)async{
    String yeniDeger="";
    await showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text("Düzenle "+ deger,style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.grey[900],
      content: TextField(
        autofocus: true,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Yeni $deger girin ",
          hintStyle: TextStyle(color: Colors.grey),
        ),
        onChanged: (value){
          yeniDeger=value;
        },
      ),
      actions: [
        TextButton(onPressed: ()=>Navigator.pop(context),
            child: Text("İptal",style: TextStyle(color: Colors.white),)
        ),
        TextButton(onPressed: ()=>Navigator.of(context).pop(yeniDeger),
            child: Text("Kaydet",style: TextStyle(color: Colors.white),)
        ),

      ],
    ));
    if(yeniDeger.trim().length>0){
      await usersCollection.doc(currentUser.email!).update({deger:yeniDeger});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: Text("Profil Sayfa",style: TextStyle(color: Colors.black),),
      backgroundColor:Colors.orange[900],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Kullanicilar").doc(currentUser.email!).snapshots(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            final userData=snapshot.data!.data() as Map<String,dynamic>;
            return ListView(
              children: [
                SizedBox(height: 30,),
                Icon(Icons.person,size: 85,),
                SizedBox(height: 10,),
                Text(currentUser.email!,textAlign: TextAlign.center,style: TextStyle(color: Colors.grey[700]),),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 23.0),
                  child: Text("Detaylar",style: TextStyle(color: Colors.grey[600]),),
                ),
                MyText(
                  text: userData["KullaniciAdi"],
                  bolumAd: "KullaniciAdi",
                  onPressed:()=> ayarlariDuzenle("KullaniciAdi"),
                ),
                MyText(
                  text: userData["bio"],
                  bolumAd: "bio",
                  onPressed:()=> ayarlariDuzenle("bio"),
                ),
              ],
            );
          }else if(snapshot.hasError){
            return Center(child: Text("Hata ${snapshot.error}"),);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}
