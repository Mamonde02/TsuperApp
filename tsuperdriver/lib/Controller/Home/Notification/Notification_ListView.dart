part of 'Notification.dart';

extension extNotifListView on _Notification {
  Widget notifListVIEW() {
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w400);
    const style2 = TextStyle(fontSize: 18.5, fontWeight: FontWeight.w400);

    return
    ListView.builder(
      itemCount: allNotif.length,
      itemBuilder: (_,i){
        var msg = allNotif[i].Msg;
        if (allNotif[i].Msg.contains("##")) {
          if (userData?.MemberType != "Driver") {
            msg = allNotif[i].Msg.split("##")[0];
          } else {
            msg = allNotif[i].Msg.split("##")[1];
          }
        }

        return
        GestureDetector(
          onTap: () {
            if (msg.contains("booked")) {
              Navigator.of(context).pop("booked");
              if (allNotif[i].Status == "ACTIVE") {
                allNotif[i].Status = "NOT";
                updateNotif(allNotif[i].ID.toString());
              }
            } else {
              Navigator.of(context).pop();
              if (allNotif[i].Status == "ACTIVE") {
                allNotif[i].Status = "NOT";
                updateNotif(allNotif[i].ID.toString());
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                            border: Border.all(color: gkGetColor(PickClr.tsuperTheme)),
                            color: allNotif[i].Status == "ACTIVE" ? Colors.grey[300]: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: bothBoxShadowV1
                          ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(formatDateFromDB("MM/dd/yyyy   hh:mm aa", allNotif[i].DateTimeIN),
                  textAlign: TextAlign.right, style: style1),
          
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(msg, style: style2),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
  
}