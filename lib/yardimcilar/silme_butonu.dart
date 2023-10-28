import 'package:flutter/material.dart';

class SilmeButonu extends StatelessWidget{
  final void Function()? onTap;


  SilmeButonu({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:Icon(Icons.delete,
        color: Colors.grey,),
    );
  }
}
