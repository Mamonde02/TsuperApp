part of 'LoginVC.dart';

extension extLogiTitle on _LoginVC {
  Widget loginTitleView(){
    const style1 = TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: Colors.white);
    const style2 = TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white);

    return RichText(
      maxLines: 2,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      text:  const TextSpan(
        children: [
           TextSpan(text: "TSUPER", style: style1),
          // 
          // typeOfApplication == "Driver" ?
          // const TextSpan(text: "\nDriver", style: style2) :
          // const TextSpan(text: "\nCar Owner", style: style2)
        ],
      ),
    );
  }
}