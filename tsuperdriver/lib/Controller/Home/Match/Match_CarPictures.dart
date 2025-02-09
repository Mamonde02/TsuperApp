part of 'MatchVC.dart';

extension extMatchCarPic on _MatchVC {
  Widget carModelVIEW() {
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700, height: 1);
    const style2 = TextStyle(fontSize: 20, fontWeight: FontWeight.w400, height: 1);

    var jsonString = (userData?.LegalProofPhotos ?? "").replaceAll("\\", "").replaceAll("\"{", "{").replaceAll("}\"", "}");
    Map<String, dynamic> legalInfo = json.decode(jsonString);

    carModel = legalInfo["CarName"];
    carTransmission = legalInfo["Transmission"];
    return
    Row(
      children: [
        Expanded(
          child: Image.network(legalInfo["CarModelImg"], height: 190,
          fit: BoxFit.fill),
        ),

        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Car Model: ", style: style1),
              Text(carModel, style: style2),
              
              spacer(15),
              const Text("Plate Number: ", style: style1),
              Text(legalInfo["PlateNumber"], style: style2),

              spacer(15),
              const Text("Car Color: ", style: style1),
              Text(legalInfo["CarColor"], style: style2),

              spacer(15),
              const Text("Transmission Type: ", style: style1),
              Text(carTransmission, style: style2),
            ],
          ),
        )
      ],
    );
  }
}