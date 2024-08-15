import 'package:flutter/material.dart';


class ShowLoadingView extends StatefulWidget {
  String nameLbl = "Checking reuqest.\nPlease wait...";
  double loadingIconWidth = 1;
  Color loadingIconColor = Colors.black;
  bool isBackable = false;

  ShowLoadingView({
    super.key, 
    this.nameLbl = "Checking request.\nPlease wait...",
    this.loadingIconWidth = 1, 
    this.loadingIconColor = Colors.black,
    this.isBackable = false
  });// = Colors.black;

  @override
  State<ShowLoadingView> createState() => _ShowLoadingView();
}

class _ShowLoadingView extends State<ShowLoadingView>{
  double loadingIconWidth = 1;
  Color loadingIconColor = Colors.black;

  @override
  Widget build(BuildContext context) {

    return
    WillPopScope(
      onWillPop: () async => true,
      child: AlertDialog(
        contentPadding: EdgeInsets.zero,
        elevation: 7,
        backgroundColor: Colors.white,
        content: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(width: 10),
                CircularProgressIndicator(
                  strokeWidth: widget.loadingIconWidth,
                  color: widget.loadingIconColor
                ),
              
                Container(width: 15),
              
                Flexible(
                  child:  Text(widget.nameLbl,
                    style: const  TextStyle(fontFamily: "SF-Pro-Round-Medium", color: Color(0xFF434343), fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}