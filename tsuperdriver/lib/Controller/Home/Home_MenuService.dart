part of 'HomeVC.dart';

extension extHomeMenuService on _HomeVC {
  Widget homeMenuServices(){

    return
    GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        ValueListenableBuilder(
          valueListenable: allSpecialReq,
          builder: (context, value, child) {
            return 
              menuDesignView(
              Icon(Icons.person_pin_circle_rounded, size: 50, color: gkGetColor(PickClr.tsuperTheme)), 
              userData?.MemberType == "Driver" ?  "Find A Client" :  "Find A Driver", (){
                specialServiceFee = 0.0;
                specialDriverBook = null;
                Navigator.of(context).push(
                  createRoute(
                    FindBooking()
                  )
                ).then((value) => {
                  if (value == "ACCEPTED") {
                    homeTabbarCtrlr.index = 1
                  }
                });
            }, 
            bubleCount: value ?? 0);
          },
        ), 

        menuDesignView(Icon(Icons.handshake , size: 50, color: gkGetColor(PickClr.tsuperTheme)), "Match", (){
          Navigator.of(context).push(
            createRoute(
              MatchVC()
            )
          );
        }),

        ValueListenableBuilder(
          valueListenable: allNotifCount,
          builder: (context, value, child) {
            return 
            menuDesignView(Icon(Icons.notifications, size: 50, color: gkGetColor(PickClr.tsuperTheme)), "Notification", (){
              Navigator.of(context).push(
                createRoute(
                  NotificationVC()
                )
              ).then((value) => {
                if (value == "booked") {
                  homeTabbarCtrlr.index = 1
                }
              });
            }, 
            bubleCount: value ?? 0);
          },
        ),

        menuDesignView(Icon(Icons.message, size: 50, color: gkGetColor(PickClr.tsuperTheme)), "Message", (){
          Navigator.of(context).push(
            createRoute(
              ChatListVC()
            )
          );
        }), 
      ],
    );
  }

  Widget menuDesignView(Icon icon, String title, void Function()? onTap, {int bubleCount = 0}){
    const style1 = TextStyle(fontSize: 20, color: Colors.black54, fontWeight: FontWeight.w700);
    const style2 = TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500);

    return
    GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.transparent,
            child: Column(
              children: [
                spacer(25),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                                color: const Color(0xFFefefef),
                                border: Border.all(color: gkGetColor(PickClr.tsuperTheme), width: 1),
                                borderRadius: BorderRadius.circular(100)
                              ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: icon,
                  ),
                ),
                
                spacer(15),
                Text(title, style: style1)
              ],
            ),
          ),

          (bubleCount > 0) ?
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 50, top: 10),
                height: 40, width: 40,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: Text("$bubleCount", style: style2)),
              ),
              Spacer()
            ],
          ): Container()
        ],
      ),
    );
  }

  void doNothing() =>();
}