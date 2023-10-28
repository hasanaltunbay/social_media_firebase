

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sosyal_medya/yardimci_fonksiyon/yardimci_fonksiyon.dart';
import 'package:sosyal_medya/yardimcilar/begenme_butonu.dart';
import 'package:sosyal_medya/yardimcilar/silme_butonu.dart';
import 'package:sosyal_medya/yardimcilar/yorum.dart';
import 'package:sosyal_medya/yardimcilar/yorum_buton.dart';

class Gonderi extends StatefulWidget{
  final String mesaj;
  final String kullanici;
  final String gonderiId;
  final String zaman;
  final List<String> begenmeler;
  final List<String> yorumlar;

  Gonderi({
    required this.mesaj,
    required this.kullanici,
    required this.gonderiId,
    required this.begenmeler,
    required this.zaman,
    required this.yorumlar,
  });

  @override
  State<Gonderi> createState() => _GonderiState();
}

class _GonderiState extends State<Gonderi> {

  final currentUser = FirebaseAuth.instance.currentUser!;
  bool begenildiMi=false;
  bool yorumYapildiMi=false;

  final yorumTextController=TextEditingController();

  @override
  void initState() {
    super.initState();
    begenildiMi=widget.begenmeler.contains(currentUser.email);
    yorumYapildiMi=widget.yorumlar.contains(currentUser.email);
  }
  void begenmeButonu(){
    setState(() {
      begenildiMi=!begenildiMi;
    });
    DocumentReference gonderiRef=FirebaseFirestore.instance.collection("Gonderiler").doc(widget.gonderiId);

    if(begenildiMi){
      gonderiRef.update({
        "Begenmeler": FieldValue.arrayUnion([currentUser.email])
      });
    }else{
      gonderiRef.update({
        "Begenmeler": FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void yorumEkle(String text){
    FirebaseFirestore.instance.collection("Gonderiler")
        .doc(widget.gonderiId)
        .collection("Yorumlar")
        .add({
      "YorumText":text,
      "YorumuYazan":currentUser.email,
      "YorumTarih":Timestamp.now(),
    });
  }
  
  void yorumShowDialog(){
    setState(() {
      yorumYapildiMi=!yorumYapildiMi;

      if(yorumYapildiMi==false){
        yorumYapildiMi=true;
      }

    });

    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Yorum Yaz"),
      content: TextField(
        controller: yorumTextController,
        decoration: InputDecoration(hintText: "Yorum Yaz..."),
      ),
      actions: [
        TextButton(onPressed:(){
         Navigator.pop(context);
         yorumTextController.clear();
        }, child: Text("İptal")),
        TextButton(onPressed:(){
          yorumEkle(yorumTextController.text);
          Navigator.pop(context);
          yorumTextController.clear();
       }, child: Text("Gönder")),
      ],
    ),);
    DocumentReference gonderiRef=FirebaseFirestore.instance.collection("Gonderiler").doc(widget.gonderiId);

    if(yorumYapildiMi){
      gonderiRef.update({
        "Yorum": FieldValue.arrayUnion([currentUser.email])
      });
    }else{
      gonderiRef.update({
        "Yorum": FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  void gonderiSil(){
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text("Gönderiyi Sil"),
      content: Text("Gönderiyi silmek istediğine emin misin?"),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("İptal",style: TextStyle(color: Colors.black),)),
        TextButton(onPressed: ()async{
          final yorumDocs=await FirebaseFirestore.instance
              .collection("Gonderiler")
              .doc(widget.gonderiId)
              .collection("Yorumlar")
              .get();

          for(var doc in yorumDocs.docs){
            await FirebaseFirestore.instance
                .collection("Gonderiler")
                .doc(widget.gonderiId)
                .collection("Yorumlar")
                .doc(doc.id)
                .delete();
          }
          FirebaseFirestore.instance
              .collection("Gonderiler")
              .doc(widget.gonderiId)
              .delete()
              .then((value) => print("Gönderi silindi"))
              .catchError(
                  (error)=>print("Gönderi silinirken hata oluştu: $error"));

          Navigator.pop(context);

        }, child: Text("Sil",style: TextStyle(color: Colors.black),)),

      ],
    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200],
      borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(15.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.mesaj,style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(widget.kullanici,style: TextStyle(color: Colors.grey[500]),),
                      Text(" . ",style: TextStyle(color: Colors.grey[500]),),
                      Text(widget.zaman,style: TextStyle(color: Colors.grey[500]),),
                    ],
                  ),
                ],
              ),
              if(widget.kullanici==currentUser.email)
                SilmeButonu(onTap: gonderiSil),
            ],
          ),
          SizedBox(height: 15,),

         Row(mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Column(
               children: [
                 BegenmeButonu(
                     isLiked: begenildiMi,
                     onTap: begenmeButonu),
                 SizedBox(height: 5,),
                 Text(widget.begenmeler.length.toString(),style: TextStyle(color: Colors.grey[600]),),
               ],
             ),
             SizedBox(width: 10,),

             Column(
               children: [
                 YorumButon(onTap: yorumShowDialog,yorumYapildiMi: yorumYapildiMi),
                 SizedBox(height: 5,),
                 Text(widget.yorumlar.length.toString(),style: TextStyle(color: Colors.grey[600]),),
               ],
             ),
           ],
         ),
          SizedBox(height: 20,),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Gonderiler")
                .doc(widget.gonderiId)
                .collection("Yorumlar")
                .orderBy("YorumTarih",descending: true)
                .snapshots(),
            builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc){
                    final yorumData=doc.data() as Map<String,dynamic>;
                    return Yorum(
                        text: yorumData["YorumText"],
                        kullanici: yorumData["YorumuYazan"],
                        zaman: TarihCevir(yorumData["YorumTarih"]),
                    );
                  }).toList(),
                );
            },
          )
        ],
      ),
    );
  }
}
