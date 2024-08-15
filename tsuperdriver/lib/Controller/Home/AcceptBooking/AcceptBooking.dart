import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Components/GlobalVar.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/CustomIcon.dart';

import '../../../Components/Colors-Design.dart';
import '../../../Model/BookingModel.dart';
import '../../../Server/Repo.dart';
import '../../../main.dart';
import '../../1. CommonUI/BackNavigation.dart';
import '../../1. CommonUI/PromptModal.dart';
import '../Notification/Notif.dart';

part 'AcceptBooking_Locations.dart';
part 'AcceptBooking_ConfirmBtn.dart';
part 'AcceptBooking_ServiceFee.dart';
part 'AcceptBooking_API_Related.dart';
part 'AcceptBooking_ScheduleDate.dart';

class AcceptBookingVC extends StatefulWidget {

  FindBookingHistoryDataModel selectedBook;

  AcceptBookingVC({super.key, required this.selectedBook});

  @override
  State<AcceptBookingVC> createState() => _AcceptBookingVC();
}

class _AcceptBookingVC extends State<AcceptBookingVC> {
  TextEditingController serviceFeeTxtController = TextEditingController();
  String selectedPymtMethod = "Cash";

  @override
  void initState() {
    selectedPymtMethod = widget.selectedBook.PaymentMethod;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w700);
    final style2 = TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey[500], height: 1);
    final style3 = TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: gkGetColor(PickClr.tsuperTheme), height: 1);
    const style4 = TextStyle(fontSize: 15, fontWeight: FontWeight.w700, height: 1);
    const style5 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700, height: 1);
    final style6 = TextStyle(fontSize: 22.5, fontWeight: FontWeight.w600, color: gkGetColor(PickClr.tsuperTheme), height: 1);

    return
    Scaffold(
      appBar: backNavigation(context, "Payment Form"),
      backgroundColor: Colors.white,

      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        children: [
          spacer(35),
          Center(child: Text(formatDateFromDB("MMMM dd, yyyy   hh:mm aa", widget.selectedBook.DateTimeIN), style: style1)),

          spacer(15),
          Text("Order No. ${widget.selectedBook.TransactionNo}", style: style2),
          const Divider(),

          Padding(        
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spacer(3.5),
                    Text(widget.selectedBook.BookerName, style: style6),
                    spacer(15),

                    const Text("Total Fare"),
                    Text("₱ ${convertCurrencyNoSymbol(widget.selectedBook.TotalAmount)}", style: style3),

                    spacer(10),
                    const Text("Total Distance"),
                    Text("${widget.selectedBook.Distance} km", style: style4),
                    
                    spacer(15),
                    const Text("Type of Service: "),
                    Text(widget.selectedBook.TypeOfService, style: style5),
                  ],
                ),
          
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Payment Method: "),

                    spacer(10),
                    
                    InkWell(
                      onTap: null,
                      child: Row(
                        children: [
                          (selectedPymtMethod == "Cash") ? 
                          const Icon(Icons.check_box_outlined) :
                          const Icon(Icons.crop_square),
                          const SizedBox(width: 15),
                          pesoPaymentIcon(),
                          const SizedBox(width: 5),
                          const Text("Cash")
                        ],
                      ),
                    ),
    
                    spacer(10),
                    
                    (selectedPymtMethod == "eCash") ? 
                    InkWell(
                      onTap: (){
                        // selectedPymtMethod = 'eCash';
                        // setState(() {});
                      },
                      child: Row(
                        children: [
                          (selectedPymtMethod == "eCash") ? 
                          const Icon(Icons.check_box_outlined) :
                          const Icon(Icons.crop_square),
                          const SizedBox(width: 15),
                          eCashPaymentIcon(),
                          const SizedBox(width: 20),
                          const Text("eCash")
                        ],
                      ),
                    ) : Container(),
                  ],
                )
              ],
            ),
          ),
          scheduleDateView(),

          spacer(15),
          carModelInfoView(),
          spacer(7),

          const Divider(),
          locationsPoint(),
          const Divider(),

          spacer(22),
          enterServiceFee(),
          
          spacer(15),
          confirmButton(),
          spacer(15),
        ],
      ),
    );
  }
  
  Widget carModelInfoView(){
    final legalInfo = widget.selectedBook.Extra1;
    Map<String,dynamic> jsonData = jsonDecode(jsonDecode(legalInfo ?? ""));
    const style1 = TextStyle(fontWeight: FontWeight.w700);
    return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              border: Border.all(width: 0.7, color: gkGetColor(PickClr.tsuperTheme)),
              borderRadius: BorderRadius.circular(35)
            ),
            child: Icon(Icons.car_rental, color: gkGetColor(PickClr.tsuperTheme), size: 35),
          ),
          
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Car Model: "),
                  Text(jsonData["CarName"].toString(), style: style1)
                ],
              ),
              
              const SizedBox(width: 35),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Car Transmission : "),
                  Text(jsonData["Transmission"].toString(), style: style1)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  void refreshState() => setState(() {});
}