import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sosyal_medya/yardimcilar/button.dart';
import 'package:sosyal_medya/yardimcilar/text_field.dart';

class KayitOl extends StatefulWidget {
  final Function()? onTap;

  KayitOl({required this.onTap});

  @override
  State<KayitOl> createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
  final emailTf=TextEditingController();
  final sifreTf=TextEditingController();
  final sifreKontrolTf=TextEditingController();

  void kayitOl()async{
    showDialog(context: context, builder: (context)=>Center(
      child: CircularProgressIndicator(),));

    if(sifreTf.text!=sifreKontrolTf.text){
      Navigator.pop(context);
      mesajGoster("Şifreler Eşleşmiyor");
      return;
    }
    try{
     UserCredential userCredential= await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTf.text,
          password: sifreTf.text);
     FirebaseFirestore.instance
         .collection("Kullanicilar")
         .doc(userCredential.user!.email!)
         .set({
          "KullaniciAdi":emailTf.text.split("@")[0],
          "bio": "Boş bio.."

     });

      if(context.mounted) Navigator.pop(context);
    }on FirebaseAuthException catch(e){
      Navigator.pop(context);
      mesajGoster(e.code);
    }
  }
  void mesajGoster(String mesaj){
    showDialog(context: context, builder: (context)=>
        AlertDialog(title: Text(mesaj),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50,),
                  Icon(Icons.person, size: 100,),
                  SizedBox(height: 50,),
                  Text("Hesap Oluştur",
                    style: TextStyle(fontSize: 25, color: Colors.black),),
                  SizedBox(height: 25,),
                  MyTextField(controller: emailTf,
                      hintText: "E-mail",
                      obscureText: false),
                  SizedBox(height: 10,),
                  MyTextField(controller: sifreTf,
                      hintText: "Şifre",
                      obscureText: true),
                  SizedBox(height: 10,),
                  MyTextField(controller: sifreKontrolTf,
                      hintText: "Şifre Kontrol ",
                      obscureText: true),
                  SizedBox(height: 10,),
                  MyButton(onTap: kayitOl, text: "Kayıt Ol"),
                  SizedBox(height: 10,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Zaten bir hesabın var!",
                        style: TextStyle(color: Colors.black),),
                      GestureDetector(
                          onTap: widget.onTap,
                          child: Text(" Giriş Yap", style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),))
                    ],
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
