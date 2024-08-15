import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';

Widget emptyView(String title){
  final style1 = TextStyle(fontSize: 18.5, color: Colors.grey[400], fontWeight: FontWeight.w400, height: 1);

  return
  Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: style1),
        Icon(Icons.broken_image_rounded, size: 150, color: Colors.grey[300])
      ],
    ),
  );
}