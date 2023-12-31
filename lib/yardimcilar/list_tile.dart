import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;

  MyListTile({required this.icon,required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        leading: Icon(icon,color: Colors.white,size: 27,),
        title: Text(text,style: TextStyle(color: Colors.white,fontSize: 22),),
        onTap: onTap,
      ),
    );
  }
}
