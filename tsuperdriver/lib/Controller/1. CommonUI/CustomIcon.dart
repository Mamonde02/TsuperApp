import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';

Widget pesoPaymentIcon(){
  const style1 = TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 11);
  return
  Stack(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 5, top: 7),
        child: Container(
          height: 22,
          width: 45,
          color:const Color.fromARGB(255, 255, 103, 1),
        ),
      ),
      Container(
        height: 25,
        width: 45,
        decoration: BoxDecoration(
          color: gkGetColor(PickClr.tsuperTheme),
          border: Border.all(color: Colors.black, width: 1)
        ),
        child:  Center(
          child: Container(
            decoration: BoxDecoration(
                          color:const Color.fromARGB(255, 255, 81, 1),
                          borderRadius: BorderRadius.circular(45)
                        ),
            child:  const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 5),
                      child:  Text("₱", style: style1, textScaleFactor: 1.0),
                    ),
          ),
        ),
      )
    ],
  );
}

Widget eCashPaymentIcon(){
  const style1 = TextStyle(fontWeight: FontWeight.w400, color: Colors.white, fontSize: 11);
  return
  Stack(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 3.5, top: 3),
        child: Container(
          height: 45,
          width: 25,
          color:const Color.fromARGB(255, 255, 103, 1),
        ),
      ),
      Container(
        height: 45,
        width: 25,
        decoration: BoxDecoration(
          color: gkGetColor(PickClr.tsuperTheme),
          borderRadius: BorderRadius.circular(2),
          border: Border.all(color: Colors.black, width: 1)
        ),
        child:  Column(
          children: [
            spacer(2),
            Container(
              width: 10,
              height: 3,
              color: Colors.white,
            ),
            const Spacer(),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                              color:Color.fromARGB(255, 255, 81, 1),
                            ),
                child:  const Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 5),
                          child:  Text("₱", style: style1, textScaleFactor: 1.0),
                        ),
              ),
            ),
            const Spacer(),

            Container(
              height: 7,
              color: Colors.white,
              child: Center(
                child: Container(
                  width: 5, height: 5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(2.5)
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget dropPickIcon({double size = 40, String type = "PickUp"}){
  return
  Container(
    width: size, height: size,
    decoration: BoxDecoration(
                  color: type == "PickUp" ? gkGetColor(PickClr.tsuperTheme) : gkGetColor(PickClr.gkBGTheme),
                  borderRadius: BorderRadius.circular(size / 2)
                ),
    child: 
    Center(
      child:  Container(
                width: size / 2, height:  size / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular((size/2) / 2)
                ),
              ),
    )
  );
}


Widget typeOfServiceIcon(String typeService){
  switch (typeService) {
    case "DropOff":
      return 
      Container(
        color: gkGetColor(PickClr.tsuperTheme),
        padding: const EdgeInsets.all(3),
        child: const Center(child: Icon(Icons.double_arrow_rounded, color: Colors.white))
      );
    case "RoundTrip":
      return 
      Container(
        color: gkGetColor(PickClr.tsuperTheme),
        padding: const EdgeInsets.all(3),
        child: const Center(child: Icon(Icons.loop_rounded, color: Colors.white,))
      );
    case "Tour":
      return 
      Container(
        color: gkGetColor(PickClr.tsuperTheme),
        padding: const EdgeInsets.all(3),
        child: const Center(child: Icon(Icons.car_rental, color: Colors.white))
      );
    default:
      return Container();
  }
}