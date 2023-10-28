import 'package:flutter/material.dart';

class YorumButon extends StatelessWidget {
  final void Function()? onTap;
  final bool yorumYapildiMi;


  YorumButon({required this.onTap,required this.yorumYapildiMi});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(Icons.comment,
        color:yorumYapildiMi ? Colors.black : Colors.grey,),
    );
  }
}
