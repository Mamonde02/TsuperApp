part of 'AccountVC.dart';

extension extAccMenu on _AccountVC {
  Widget menuVIEW(){
    return
    Padding(
      padding: const EdgeInsets.only(left: 35, right: 15),
      child: Column(
        children: [
          spacer(45),
          menuDesign(
          Icon(Icons.chat_bubble_outlined, color: gkGetColor(PickClr.tsuperTheme), size: 55), 
          "Support", (){
            Navigator.of(context).push(
              createRoute(ChatSupportVC())
            );
          }),

          spacer(15),
          menuDesign(Icon(Icons.logout_outlined, color: gkGetColor(PickClr.tsuperTheme), size: 55), 
          "Log Out",
          (){
            appLogout(context, mounted);
          })
        ],
      ),
    );
  }

  Widget menuDesign(Icon icon, String lbl, void Function() func){
    const style1 = TextStyle(fontSize: 17.5);
    return
    GestureDetector(
      onTap: func,
      child: Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
      
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lbl, style: style1),
      
                  spacer(10),
                  Divider(color: Colors.grey[300], height: 1)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}