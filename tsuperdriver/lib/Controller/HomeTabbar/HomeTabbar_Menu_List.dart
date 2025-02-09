part of 'HomeTabbarVC.dart';

extension extMenuList on _HomeTabbarVC{
  Widget tabBottomMenu() {
    return 
    Container(
      height: 80,
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -3),
            blurRadius: 3,
          ),
        ],
      ),

      child: TabBar(
        labelColor: gkGetColor(PickClr.gkBGTheme),
        unselectedLabelColor: Colors.grey[400],
        labelStyle: const TextStyle(fontSize: 13.5),
        indicator:  BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: gkGetColor(PickClr.tsuperTheme),
                          width: 3.0
                        ),
                      ),
                    ),
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        controller: homeTabbarCtrlr,
        tabs: tabbarMenus(selectedIndex)
      )
    );
  }

  List<Widget> tabbarMenus(int gkIndex) {
    return 
    [
      tabIconDesignUI("Home", const Icon(Icons.home, size: 35), gkIndex == 0 ? "1" : "0"),
      tabIconDesignUI("Booking", const Icon(Icons.settings_suggest, size: 35), gkIndex == 1 ? "1" : "0"),
      tabIconDesignUI("History", const Icon(Icons.receipt_long, size: 35), gkIndex == 2 ? "1" : "0"),
      tabIconDesignUI("Account", const Icon(Icons.person, size: 35), gkIndex == 3 ? "1" : "0")
    ];
  }

  Widget tabIconDesignUI(String tabName, Icon imgIcon, String isActive) {
    const style1 = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
    return 
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        Opacity(
          opacity: isActive == "1" ? 1 : 0.35,
          child: imgIcon,
        ),
        const SizedBox(height: 5),
        Text(tabName, style: style1, textAlign: TextAlign.center,)
      ]
    );
  }
}
