part of 'BookingVC.dart';

extension extBookingSearchPlaceNow on _BookingVC {
  Widget googlePlaceSearch(String type){
    
    return
    GooglePlaceAutoCompleteTextField(
      boxDecoration:  const BoxDecoration(
                        color: Colors.white
                      ),
      textEditingController: (type == "Pickup") ? pickTxtController : dropOffTxtController,
      googleAPIKey: "AIzaSyDq3mBAg7gSUGkZPkMj-bUFy45r1xzXxMc",
      inputDecoration:  const InputDecoration(
                          hintText: "Search Places",
                        ),
      debounceTime: 1000, // default 600 ms,
      countries: const ["ph"],// optional by default null is set
      isLatLngRequired:true,// if you req is called when isLatLngRequired is true
      getPlaceDetailWithLatLng: (Prediction prediction) async {
        if (type == "Pickup"){
          pickupPlace = "${prediction.description.toString()}:::${prediction.lat.toString()}:::${prediction.lng.toString()}";
          pickupLatLng = [prediction.lat.toString(),prediction.lng.toString()];
        }else{
          dropOffPlace = "${prediction.description.toString()}:::${prediction.lat.toString()}:::${prediction.lng.toString()}";
          dropOffLatLng = [prediction.lat.toString(),prediction.lng.toString()];
        }
        setState(() {});
      },
      itemClick: (Prediction prediction) {
        if (type == "Pickup"){
          pickTxtController.text= prediction.description.toString();
          pickTxtController.selection = TextSelection.fromPosition(TextPosition(offset: (prediction.description ?? ".").length));
        }else{
          dropOffTxtController.text= prediction.description.toString();
          dropOffTxtController.selection = TextSelection.fromPosition(TextPosition(offset: (prediction.description ?? ".").length));
        }
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
    );
  }
}