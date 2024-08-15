import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/Colors-Design.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';

import '../../../Components/GlobalVar.dart';
import '../../../Model/BookingModel.dart';
import '../../../Server/Repo.dart';
import '../1. CommonUI/CustomIcon.dart';
import '../1. CommonUI/PromptModal.dart';

part 'History_API_Related.dart';
part 'History_ListView.dart';

class HistoryVC extends StatefulWidget {
  const HistoryVC({super.key});


  @override
  State<HistoryVC> createState() => _HistoryVC();
}

class _HistoryVC extends State<HistoryVC> {
  List<BookingHistoryDataModel> allHistory = [];

  @override
  void initState() {
    viewHistory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const style1 = TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.w700);
    AppBar appBar = AppBar(
                      backgroundColor:gkGetColor(PickClr.tsuperTheme),
                      elevation: 0,
                      iconTheme: const IconThemeData(color: Colors.white, size: 30),
                      automaticallyImplyLeading: false,
                      title: const Text("History", style: style1),
                    );
    return
    Scaffold(
      backgroundColor: gkGetColor(PickClr.gkBGStyle1),
      appBar: appBar,
      body: historyList(),
    );
  }

  void refreshState() => setState(() {});
}