import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';

import '../../../../Components/CommonFunc.dart';

class BookingConfirmation extends StatelessWidget {
  Map<String, dynamic> confirmationData = {};
  
  double distance = 0;

  BookingConfirmation({
    super.key,
    required this.confirmationData
  });

  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500, color: Colors.white);
    const style2 = TextStyle(fontSize: 20.5, fontWeight: FontWeight.w500);

    determineDistance();

    return
    Material(
      color: Colors.transparent,
      child: Column(
        children: [
          
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3)
                        ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                spacer(5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text("Confirmation", style: style2),
                ),

                spacer(15),

                Row(
                  children: [
                    Column(
                      children: [
                        const Text("Total Amount", style: style1),
                        spacer(5),
                        Text("Php ${convertCurrencyNoSymbol(45 + ((distance/300) * 10))}", 
                        style: style2)
                      ],
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                          color: Colors.red,
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 7),
                            child: Text("Cancel", style: style1),
                          ),
                        ),
                      ),
                
                      const SizedBox(width: 10),
                      Expanded(
                        child: MaterialButton(
                          color: gkGetColor(PickClr.tsuperTheme),
                          onPressed: (){
                            
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 7),
                            child: Text("Confirm", style: style1),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void determineDistance(){
    if (confirmationData["TypeService"] == "DropOff"){
      final pickUpArr = confirmationData["PickUp"].split(":::");
      final lat1 = double.parse(pickUpArr[1]);
      final long1 = double.parse(pickUpArr[2]);

      final dropOffArr = confirmationData["DropOff"].split(":::");
      final lat2 = double.parse(dropOffArr[1]);
      final long2 = double.parse(dropOffArr[2]);

      distance = Geolocator.distanceBetween(lat1, long1, lat2, long2);
      
    }else if (confirmationData["TypeService"] == "RoundTrip"){

    }else{

    }
  }
}