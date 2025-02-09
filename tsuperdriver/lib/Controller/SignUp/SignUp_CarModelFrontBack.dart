part of 'SignUpVC.dart';

extension extSignUPCarFrontBack on _SignUpVC {
  Widget driverCarVIEW() {
    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spacer(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            driverCarFrontBack("Front"),
            
            const SizedBox(width: 15),
            driverCarFrontBack("Back"),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (carModelFront.isNotEmpty) ?
            imgViewer(carModelFrontImg!) :
            emptyImgView(),

            const SizedBox(width: 15),
            (carModelBack.isNotEmpty) ?
            imgViewer(carModelBackImg!) :
            emptyImgView(),
          ],
        ),
      ],
    );
  }
  
  Widget driverCarFrontBack(String type){
    final style1 =  TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: gkGetColor(PickClr.tsuperTheme));

    return
    Expanded(
      child: MaterialButton(
        shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.5),
                  side: BorderSide(color: gkGetColor(PickClr.gkBtnColor), width: 1.5)
                ),
        elevation: 2,
        onPressed: () async{
          final image = await showSelectPhotoCameraModalView(context);
          if ((image?.path ?? ".") != "."){
            final finalName = "${fnameTxtController.text}-DriverCarModel$type-${getDateFromNOW("hhmmssddyyyyMM")}";
            if (type == "Front") {
              carModelFront = [image,finalName];
              carModelFrontImg = await image!.readAsBytes();
            } else {
              carModelBack = [image,finalName];
              carModelBackImg = await image!.readAsBytes();
            }
            setState(() {});
          }
        },
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Text(type, style: style1),
        ),
      ),
    );
  }  

  Widget carModelVIEW() {
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500, color: Colors.white);

    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spacer(20),
        const Text("Upload Car Model: ", style: style1),
        carModelUploadBtn(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (carModel.isNotEmpty) ?
            imgViewer(carModelImg!, height: 220) :
            emptyImgView(height: 220),

            const SizedBox(width: 15),
            Expanded(
              child: Column(
                children: [
                  carNameTxtField(),
                  carPlateNumbeTxtField(),
                  carColorxtField(),
                  carTransmissionDropDown()
                ],
              ),
            )
          ]
        )
      ],
    );
  }
}