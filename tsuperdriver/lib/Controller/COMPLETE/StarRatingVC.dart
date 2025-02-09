import 'package:flutter/material.dart';

import '../../Components/Colors-Design.dart';
import '../../Components/GlobalVar.dart';

class StarRatingVC extends StatefulWidget {
  int selectedStar = 0;

  @override
  State<StarRatingVC> createState() => _StarRatingVC();
}

class _StarRatingVC extends State<StarRatingVC> {
  @override
  Widget build(BuildContext context) {
    return
    Material(
      child:
      SizedBox(
        height: 35,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, i){
            return
            GestureDetector(
              onTap: (){
                setState(() {
                  widget.selectedStar = i;
                  starRating = i;
                });
              },
              child: Icon(
                i <= widget.selectedStar ? 
                Icons.star :
                Icons.star_border_outlined, 
                color: gkGetColor(PickClr.tsuperTheme),
                size: 30
              )
            );
          }
        ),
      )
    );
  }
}