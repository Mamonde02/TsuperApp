import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';
import 'package:tsuperdriver/Controller/1.%20CommonUI/BackNavigation.dart';
import '../../../Model/Account/AccoutModel.dart';
import '../../../Model/BookingModel.dart';
import '../../../Server/Repo.dart';
import '../FindBooking/FindBooking.dart';

part 'DriverReviews_API_Related.dart';

class DriverReviewsVC extends StatefulWidget {
  UserAccountDataModel driverInfo;
  DriverReviewsVC({
    super.key,
    required this.driverInfo
  });
  
  @override
  State<DriverReviewsVC> createState() => _DriverReviewsVC();
}

class _DriverReviewsVC extends State<DriverReviewsVC> {
  List<DriverRatingReviewDataModal> reviewsData = [];

  @override
  void initState() {
    fetchReviewRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final style1 = TextStyle(fontSize: 20, color: gkGetColor(PickClr.tsuperTheme), fontWeight: FontWeight.w500);
    const style2 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w400);
    const style3 = TextStyle(fontSize: 17.5, fontWeight: FontWeight.w400, height: 1);
    final style4 = TextStyle(fontSize: 17.5, fontWeight: FontWeight.w400, height: 1, color: Colors.grey[500]);

    return
    Scaffold(
      appBar: backNavigation(context, "Ratings and Comments"),
      backgroundColor: gkGetColor(PickClr.gkBGStyle1),

      body: 
      ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 15),
        itemCount: reviewsData.length,
        shrinkWrap: true,
        itemBuilder: (_,i){
          final name = "${reviewsData[i].ClientName.substring(0,3)}******";
          final coment = reviewsData[i].Comment.isEmpty ? "No Comment" : reviewsData[i].Comment;
          return
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(name, style: style1),
                    
                    const SizedBox(width: 20),
                    Text(formatDateFromDB("MM/dd/yyyy hh:mm aa", reviewsData[i].DateTimeIN), style: style2),
                  ]
                ),

                spacer(10),
                starRatingsView(reviewsData[i].Rate),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(3)
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Text(coment, style: coment == "No Comment" ? style4 : style3),
                ),

                spacer(7),
                Container(
                  height: 1,
                  color: Colors.grey[300],
                )
              ],
            ),
          );
        }
      )
    );
  }

  void refreshState() => setState(() {});
}