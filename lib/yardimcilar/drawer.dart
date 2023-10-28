import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sosyal_medya/yardimcilar/list_tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onTapProfil;
  final void Function()? onTapCikisYap;

  MyDrawer({required this.onTapProfil,required this.onTapCikisYap});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.orange[800],
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(child: Icon(Icons.person,color: Colors.white,size: 70,)),
              MyListTile(
                icon: Icons.home,
                text: "ANASAYFA",
                onTap: ()=>Navigator.pop(context),
              ),
              MyListTile(
                icon: Icons.person,
                text: "PROFİL",
                onTap: onTapProfil,
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: MyListTile(
              icon: Icons.logout,
              text: "ÇIKIŞ YAP",
              onTap: onTapCikisYap,
            ),
          ),
        ],
      ),
    );
  }
}
