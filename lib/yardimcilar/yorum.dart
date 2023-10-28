import 'package:flutter/material.dart';

class Yorum extends StatelessWidget {
  final String text;
  final String kullanici;
  final String zaman;


  Yorum({required this.text,required this.kullanici,required this.zaman});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      margin: EdgeInsets.only(bottom: 5),
      padding: EdgeInsets.all(15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text),
          SizedBox(height: 5,),
          Row(
            children: [
              Text(kullanici,style: TextStyle(color: Colors.grey[500]),),
              Text(" . ",style: TextStyle(color: Colors.grey[500]),),
              Text(zaman,style: TextStyle(color: Colors.grey[500]),),
            ],
          ),
        ],
      ),
    );
  }
}
