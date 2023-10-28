import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sosyal_medya/yardimcilar/button.dart';
import 'package:sosyal_medya/yardimcilar/text_field.dart';


class GirisYap extends StatefulWidget {
  final Function()? onTap;


  GirisYap({required this.onTap});

  @override
  State<GirisYap> createState() => _GirisYapState();
}

class _GirisYapState extends State<GirisYap> {

  final emailTf=TextEditingController();
  final sifreTf=TextEditingController();

  void girisYap()async{
    
    showDialog(context: context, builder: (context)=> Center(
      child: CircularProgressIndicator(),));
    
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTf.text,
          password: sifreTf.text);
      if(context.mounted) Navigator.pop(context);
    }on FirebaseAuthException catch(e){
      Navigator.pop(context);
      mesajGoster(e.code);
    }
  }

  void mesajGoster(String mesaj){
    showDialog(context: context, builder: (context)=>AlertDialog(title: Text(mesaj),));
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
                  Icon(Icons.person,size: 100,),
                  SizedBox(height: 50,),
                  Text("Tekrardan Hoşgeldiniz",style: TextStyle(fontSize: 25,color: Colors.black),),
                  SizedBox(height: 25,),
                  MyTextField(controller: emailTf, hintText: "E-mail", obscureText: false),
                  SizedBox(height: 10,),
                  MyTextField(controller: sifreTf, hintText: "Şifre", obscureText: true),
                  SizedBox(height: 10,),
                  MyButton(onTap:girisYap, text: "Giriş Yap"),
                  SizedBox(height: 10,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Kayıt olmadın mı?",style: TextStyle(color: Colors.black),),
                      GestureDetector(
                        onTap:widget.onTap,
                          child: Text(" Kayıt Ol",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),))
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
