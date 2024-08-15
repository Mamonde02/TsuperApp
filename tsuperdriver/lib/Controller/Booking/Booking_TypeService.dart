part of 'BookingVC.dart';

extension extBookingTypeService on _BookingVC {
  Widget typeOfServiceView(){
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
          const Text("Type of Service", style: style1),

          spacer(10),
          serviceMenuDesign(const Icon(Icons.double_arrow_rounded), "Drop Off", "DropOff"),

          spacer(10),
          serviceMenuDesign(const Icon(Icons.loop_rounded), "Round Trip", "RoundTrip"),

          spacer(10),
          serviceMenuDesign(const Icon(Icons.car_rental), "Tour", "Tour"),

          spacer(10),
        ],
      ),
    );
  }

  Widget serviceMenuDesign(Icon icon, String title, String type){
    const style1 = TextStyle(fontSize: 17.5, fontWeight: FontWeight.w500);
    var isSelected = type == selectedService ? true : false;

    return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: MaterialButton(
        onPressed: (){
          selectedService = type;
          refreshState();
        },
    
        child:
        Row(
          children: [
            Material(
              color: gkGetColor(PickClr.tsuperTheme),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: icon,
              )
            ),
    
            const SizedBox(width: 15),
            Icon(isSelected ? Icons.circle_rounded : Icons.circle_outlined),
            const SizedBox(width: 5),
            Text(title, style: style1)
          ],
        )
      ),
    );
  }
}