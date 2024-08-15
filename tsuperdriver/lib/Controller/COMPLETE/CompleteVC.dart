import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/COMPLETE/StarRatingVC.dart';

import '../../Server/Repo.dart';
import '../1. CommonUI/PromptModal.dart';
import '../Booking/Waiting For Driver/WaitingForDriver.dart';

part 'Complete_API_Related.dart';

class CompleteTrxn extends StatelessWidget {
  TextEditingController commentTxtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontSize: 18.5, fontWeight: FontWeight.w700, color: Colors.green);
    final style2 = TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: gkGetColor(PickClr.tsuperTheme));
    final style3 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500, color: gkGetColor(PickClr.gkDarkBlue));
    const style4 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700, height: 1);
    const style5 = TextStyle(fontSize: 15.5, color: Colors.grey);

    return
    GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                spacer(35),
              
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 28),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3)
                              ),
                  child: 
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle_outline_outlined, color: Colors.green, size: 70),
                      spacer(5),
                      const Text("Transaction Complete", style: style1),
                  
                      spacer(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.5),
                        child: Divider(color: Colors.grey[400]),
                      ),
                  
                      Text(pendingBookingInfo?.TransactionNo.toString() ?? "", style: style4),
                      Text(pendingBookingInfo?.BookerName ?? "", style: style2),
                      Text(getDateFromNOW("MM/dd/yyyy hh:mm aa"), style: style5),
                      
                      spacer(10),
                      serviceTypeView(),
                  
                      Text("Distance: ${pendingBookingInfo?.Distance} km", style: style3),
                      Text("Amount: Php ${pendingBookingInfo?.TotalAmount}", style: style3),
                      Text("Service Fee: Php ${pendingDriverBookingInfo?.ServiceFee}", style: style3),
                      Text("Total Amount: Php ${(pendingDriverBookingInfo?.ServiceFee ?? 0) + (pendingBookingInfo?.TotalAmount ?? 0)}", style: style3),
                      
                      spacer(10),
                      rateDriverView(),
                      Text("Driver: ${pendingDriverBookingInfo?.DriverName}", style: style3),
                      Text("Service Fee: Php ${pendingDriverBookingInfo?.ServiceFee}", style: style3),
                      
                      (userData?.MemberType == "Driver") ?
                      Container() :
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          spacer(10),
                          StarRatingVC(),
                          spacer(5),
                          TextFormField(
                            controller: commentTxtController,
                            autofocus: true,
                            autocorrect: false,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFF2F2F2),
                              hintText: "Comment Here (Optional)",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                  borderSide: BorderSide(width: 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                
                      spacer(15),
                      MaterialButton(
                        onPressed: (){
                          if (userData?.MemberType == "Driver") {
                            pendingBookingInfo = null;
                            pendingDriverBookingInfo = null;
                            if (!context.mounted) return;
                            Navigator.of(context).pop("CLOSE");
                            return;
                          }
                          rateDriver(context);
                        },
                        child: const 
                        Text("Close", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.green)),
                        
                      ),
                      
                       MaterialButton(onPressed: (){
                          if (userData?.MemberType == "Driver") {
                            pendingBookingInfo = null;
                            pendingDriverBookingInfo = null;
                            if (!context.mounted) return;
                            Navigator.of(context).pop("CLOSE");
                            return;
                          }
                          rateDriver(context);
                        },
                        child: const 
                        Text("Enter", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.green)), ) 
                      
                    ],
                  ),
                ),
                spacer(15),
                spacer(MediaQuery.of(context).viewInsets.bottom)
              ],
            ),
          ),
        ),
      ),
    );
  }
}