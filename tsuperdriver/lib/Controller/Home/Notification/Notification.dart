import 'package:flutter/material.dart';
import 'package:tsuperdriver/Components/CommonFunc.dart';

import '../../../Components/Colors-Design.dart';
import '../../../Components/GlobalVar.dart';
import '../../../Server/Repo.dart';
import '../../1. CommonUI/BackNavigation.dart';
import '../../1. CommonUI/PromptModal.dart';

part 'Notification_ExtAPI.dart';
part 'Notification_ListView.dart';

class NotificationVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Notification();
}

class _Notification extends State<NotificationVC> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
    Scaffold(
      appBar: backNavigation(context, "Notificataion"),
      backgroundColor: gkGetColor(PickClr.gkBGStyle2),

      body: notifListVIEW(),
    );
  }
}