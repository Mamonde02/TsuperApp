import 'package:flutter/material.dart';
import 'package:tsuperadmin/Components/GlobalVar.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/PromptModal.dart';
import 'package:tsuperdriver/Model/BookingModel.dart';

import '../../Server/Repo.dart';
import 'Generate Report/GenerateReportVC.dart';

part 'Booking_SearchTxt.dart';
part 'Booking_API_Related.dart';
part 'Booking_ListView.dart';

class BookingVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BookingVC();
}

class _BookingVC extends State<BookingVC> {
  TextEditingController searchTxtController = TextEditingController();

  List<BookingDataModel> allBookingData = [];
  List<BookingDataModel> displayBookingData = [];

  @override
  void initState() {
    fetchAllBooking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
    Material(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: 
      (subDisplayType == "Generate Report") ?
      GenerateReportVC(allBookingData: allBookingData) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: gkGetColor(PickClr.gkBtnColor),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 15),
                navigationBtn(didTapGenerateBtn, "Generate Report"),

                const Spacer(),
                searchTxtView(),
                const SizedBox(width: 30),
              ],
            ),
          ),
          
          bookingListVIEW() 
        ],
      ),
    );
  }
  
  void refreshState() => setState(() {});

  String formatLocations(String locations){
    final arrLocations = locations.split("##");
    var address = "";
    for (var e in arrLocations) {
      final area = e.split(",");
      address += address == "" ? area[0] : ", ${area[0]}";
    }

    return address;
  }

  void didTapGenerateBtn(){
    subDisplayType = "Generate Report";
    refreshState();
  }
}

Widget navigationBtn(void Function() didTap, String title){
  const style1 = TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white);
  return 
  TextButton(
    style:  ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.5))),
              fixedSize: MaterialStateProperty.all(const Size(200, 50)),
              elevation: MaterialStateProperty.all(2),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (title == subDisplayType) {return Colors.orange[300]!;}
                  if (states.contains(MaterialState.hovered))  {return Colors.orange[300]!;}
                  return gkGetColor(PickClr.tsuperTheme);
                }
              ),
            ),
    onPressed: didTap, 
    child: Text(title, style: style1)
  );
}