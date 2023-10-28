import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final String bolumAd;
  final void Function()? onPressed;


  MyText({required this.text,required this.bolumAd,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(bolumAd,style: TextStyle(color: Colors.grey[500]),),
              IconButton(onPressed: onPressed, icon: Icon(Icons.settings,color: Colors.grey[500],)),
            ],
          ),

          Text(text),
        ],
      ),

    );
  }
}
