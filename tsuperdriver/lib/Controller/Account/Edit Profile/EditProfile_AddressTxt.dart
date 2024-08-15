part of 'EditProfileVC.dart';

extension extAddressTxtCurrent on _EditProfileVC {
  Widget googlePlaceSearch(){
    const style1 = TextStyle(fontSize: 18.5);
    
    return
    Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Current Address", style: style1),
          GooglePlaceAutoCompleteTextField(
            boxDecoration:   BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3.5),
                              border: Border.all(color: Colors.grey[200]!)
                            ),
            textEditingController: currentAddressTxtController,
            googleAPIKey: "AIzaSyDq3mBAg7gSUGkZPkMj-bUFy45r1xzXxMc",
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            inputDecoration:  InputDecoration(
                                isDense: true,
                                hintText: "Current Address",
                                hintStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.grey[400]),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none
                              ),
            debounceTime: 1000, // default 600 ms,
            countries: const ["ph"],// optional by default null is set
            isLatLngRequired:true,// if you req is called when isLatLngRequired is true
            getPlaceDetailWithLatLng: (Prediction prediction) async {
              currentAddress = "${prediction.description.toString()}:::${prediction.lat.toString()}:::${prediction.lng.toString()}";
              setState(() {});
            },
            itemClick: (Prediction prediction) {
              currentAddressTxtController.text= prediction.description.toString();
              currentAddressTxtController.selection = TextSelection.fromPosition(TextPosition(offset: (prediction.description ?? ".").length));
            },
            
            // if we want to make custom list item builder
            itemBuilder: (context, index, Prediction prediction) {
              return Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(
                      width: 7,
                    ),
                    Expanded(child: Text(prediction.description??""))
                  ],
                ),
              );
            },
            // if you want to add seperator between list items
            seperatedBuilder: const Divider(),
            // want to show close icon 
            isCrossBtnShown: true,
          ),
        ],
      ),
    );
  }
}