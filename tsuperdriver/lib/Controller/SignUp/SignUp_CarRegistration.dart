part of 'SignUpVC.dart';

extension extSignCarReg on _SignUpVC {
  Widget carRegistrationVIEW() {
    const style1 = TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500, color: Colors.white);

    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        spacer(20),
        const Text("Car Registration: ", style: style1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            carRegFrontBack("Front"),
            
            const SizedBox(width: 15),
            carRegFrontBack("Back"),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (carRegistrationFront.isNotEmpty) ?
            imgViewer(carRegImgFront!) :
            emptyImgView(),

            const SizedBox(width: 15),
            (carRegistrationBack.isNotEmpty) ?
            imgViewer(carRegImgBack!) :
            emptyImgView(),
          ],
        )
      ],
    );
  }
  
  Widget carRegFrontBack(String type){
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
            final finalName = "${fnameTxtController.text}-CarReg$type-${getDateFromNOW("hhmmssddyyyyMM")}";
            if (type == "Front") {
              carRegistrationFront = [image,finalName];
              carRegImgFront = await image!.readAsBytes();
            } else {
              carRegistrationBack = [image,finalName];
              carRegImgBack = await image!.readAsBytes();
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