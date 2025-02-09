part of 'BookingVC.dart';

extension extPickDropOff on _BookingVC {
  Widget pickDropOffView(){
    const style1 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700);
    return
    Container(
      margin: const EdgeInsets.only(left: 18, right: 18, top: 35),
      decoration: BoxDecoration(
                    border: Border.all(color: gkGetColor(PickClr.tsuperTheme), width: 1),
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                    boxShadow: bothBoxShadowV1
                  ),
      child: Column(
        children: [
          spacer(10),
          searchColumnDesign(gkGetColor(PickClr.tsuperTheme), "Pickup", pickupPlace),

          Divider(color: gkGetColor(PickClr.tsuperTheme)),
          searchColumnDesign(gkGetColor(PickClr.gkBGTheme), "Drop-off", dropOffPlace),
          spacer(10),
        ],
      ),
    );
  }

  Widget searchColumnDesign(Color color, String lbl, String search){

    return
    GestureDetector(
      onTap: (){
        // showPromptModal(lbl);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Row(
          children: [
            const SizedBox(width: 5),
            (lbl == "Pickup") ?
            dropPickIcon(size: 20, type: "Pickup") :
            dropPickIcon(size: 20),
    
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: Text(lbl),
                  ),
                  googlePlaceSearch(lbl)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}