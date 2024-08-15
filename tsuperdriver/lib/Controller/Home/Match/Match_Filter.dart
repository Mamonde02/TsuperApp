part of 'MatchVC.dart';

extension extMatchFilter on _MatchVC {
  Widget matchFilterVIEW() {
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, height: 1);
    const style2 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, height: 1);
    var jsonString = (userData?.LegalProofPhotos ?? "").replaceAll("\\", "").replaceAll("\"{", "{").replaceAll("}\"", "}");
    Map<String, dynamic> legalInfo = json.decode(jsonString);

    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        spacer(10),
        const Text("Car Model (Optional) :", style: style1),

        spacer(2.5),
        Row(
          children: [
            Checkbox(
              value: matchCarModel,
              visualDensity: VisualDensity.compact, 
              onChanged: (value) {
                matchCarModel = value ?? false;
                refreshState();
            }),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color:Colors.grey[200],
                                border: 
                                matchCarModel ?
                                Border.all(color: Colors.blue, width: 2) :
                                Border.all(color:Colors.grey)
                              ),
                child: Text(legalInfo["CarName"], style: style2)
              ),
            )
          ],
        ),

        spacer(10),
        googlePlaceSearch()
      ],
    );
  }

  Widget matchDriverFilterVIEW() {
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, height: 1);
    const style2 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, height: 1);
    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        spacer(10),
        const Text("Car Model (Optional) :", style: style1),

        spacer(2.5),
        TextField(  
          cursorColor: Colors.black,
          textAlign: TextAlign.start,
          controller: carModelTxtController,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 12, bottom: 11, left: 15),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
              hintStyle: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey[400])
            ),
          ),

        spacer(12),

        const Text("Car Transmission :", style: style1),
        spacer(2.5),
        carTransmissionDropDown(),

        spacer(7),
        googlePlaceSearch()
      ],
    );
  }
}