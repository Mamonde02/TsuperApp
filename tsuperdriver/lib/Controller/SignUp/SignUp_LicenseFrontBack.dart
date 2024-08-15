part of 'SignUpVC.dart';

extension extSignUPLicenseFrontBack on _SignUpVC {
  Widget driverLicenseVIEW() {
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500, color: Colors.white);

    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spacer(10),
        const Text("Upload Driver License: ", style: style1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            driverLicenseFrontBack("Front"),
            
            const SizedBox(width: 15),
            driverLicenseFrontBack("Back"),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (driverLicenseFront.isNotEmpty) ?
            imgViewer(licenseFront!) :
            emptyImgView(),

            const SizedBox(width: 15),
            (driverLicenseBack.isNotEmpty) ?
            imgViewer(licenseBack!) :
            emptyImgView(),
          ],
        ),

        (selectedMemberType != "Driver") ?
        carModelVIEW() :
        Container()
      ],
    );
  }
  
  Widget driverLicenseFrontBack(String type){
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
            final finalName = "${fnameTxtController.text}-DriverLicense$type-${getDateFromNOW("hhmmssddyyyyMM")}";
            if (type == "Front") {
              driverLicenseFront = [image,finalName];
              licenseFront = await image!.readAsBytes();
            } else {
              driverLicenseBack = [image,finalName];
              licenseBack = await image!.readAsBytes();
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
}