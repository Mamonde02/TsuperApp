part  of '../BookingVC.dart';

extension extBookingTour on _BookingVC {
  Widget locationVIEW(){
    return
    Container(
      margin: const EdgeInsets.only(left: 18, right: 18, top: 35),
      height: 200,
      decoration: BoxDecoration(
                    border: Border.all(color: gkGetColor(PickClr.tsuperTheme), width: 1),
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                    boxShadow: bothBoxShadowV1
                  ),
      child: Column(
        children: [
          Container(
            color: gkGetColor(PickClr.tsuperTheme),
            height: 50,
            child: Row(
              children: [
                const SizedBox(width: 5),
                InkWell(
                  onTap: (){
                    showConfirmationPromptModal();
                  },
                  child: const Icon(Icons.add, color: Colors.white,),
                ),

                const SizedBox(width: 15),
                InkWell(
                  onTap: (){
                    locations.removeWhere((e) => e == selectedLocaiton);
                    selectedLocaiton = "";
                    refreshState();
                  },
                  child: const Icon(Icons.remove, color: Colors.white,),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: locations.length,
              shrinkWrap: true,
              itemBuilder: (_, i){
                String nameLocation = locations[i].split(":::")[0];
                return
                Container(
                  color: selectedLocaiton == locations[i] ? Colors.grey[300] : Colors.white,
                  child: TextButton(
                    onPressed: (){
                      selectedLocaiton = locations[i];
                      refreshState();
                    }, 
                    child: Text(nameLocation, textAlign: TextAlign.start)
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}