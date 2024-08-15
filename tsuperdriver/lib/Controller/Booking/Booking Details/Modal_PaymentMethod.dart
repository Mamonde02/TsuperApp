import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';

import '../../1. CommonUI/CustomIcon.dart';

class ModalPaymentMethod extends StatelessWidget {
  const ModalPaymentMethod({super.key});


  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700);
    const style2 = TextStyle(fontSize: 22, fontWeight: FontWeight.w700);

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Payment Method", style: style2),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.close, color: Colors.grey[400], size: 30),
                      )
                    ],
                  ),
                ),

                spacer(5),
                MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  onPressed: (){
                    Navigator.of(context).pop("Cash");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      pesoPaymentIcon(),
                      const SizedBox(width: 15),
                      const Text("Cash", style: style1),
                    ],
                  ),
                ),
                
                MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  onPressed: (){
                    Navigator.of(context).pop("eCash");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      eCashPaymentIcon(),
                      const SizedBox(width: 22),
                      const Text("eCash", style: style1),
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
}