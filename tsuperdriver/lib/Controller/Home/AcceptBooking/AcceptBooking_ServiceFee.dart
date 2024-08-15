part of 'AcceptBooking.dart';

extension extServiceFee on _AcceptBookingVC {
  Widget enterServiceFee(){
    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Service Fee (Optional):"),

        spacer(2),
        TextField(
          cursorColor: Colors.black,
          textAlign: TextAlign.start,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          controller: serviceFeeTxtController,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 12, bottom: 11, left: 25, right: 10),
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(fontSize: 15, color: Colors.grey[400]),
            hintText: "Optional",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder:  OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[200]!),
                            ),
            enabledBorder:  OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[200]!),
                            ),
          ),
        ),
      ],
    );
  }
}