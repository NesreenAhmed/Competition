import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class TPlayButtonContainer extends StatelessWidget {
  const TPlayButtonContainer({super.key,required this.onTap,required this.icon,required this.text});
  final VoidCallback onTap;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: const Color(0XFF5287ff),),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,color: const Color(0XFFd0e0f8),size: 25,),
            Text(text,style: const TextStyle(color: Color(0XFFd0e0f8),fontWeight: FontWeight.w600),),
          ],
        ),
      ),
    );
  }
}
