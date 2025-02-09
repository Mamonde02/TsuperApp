import 'package:flutter/material.dart';

enum PickClr { 
  pdyGreenTheme, pdyBtnColor, gkBGTheme,
  gkDarkBlue, gkSkyBlue, gkBtnColor, gkTitle,
  gkBGStyle1, gkBGStyle2, titleHeader, tsuperTheme
}

Color gkGetColor(PickClr colorName){
  Color returnedColor;
  switch (colorName) {
    case PickClr.tsuperTheme:
      returnedColor = const Color(0xFFff7a01);
      break;
    case PickClr.pdyGreenTheme:
      returnedColor = const Color(0xFF86A16A);
      break;
    case PickClr.pdyBtnColor:
      returnedColor = const Color(0xFF9ECA7D);
      break;
    case PickClr.gkBGTheme:
      returnedColor = const Color(0xFF124D6D);
      break;
    case PickClr.gkDarkBlue:
      returnedColor = const Color(0xFF124E6F);
      break;
    case PickClr.gkSkyBlue:
      returnedColor = const Color(0xFF3BBDD5);
      break;
    case PickClr.gkBtnColor:
      returnedColor = const Color(0xFF45D8FF);
      break;
    case PickClr.gkTitle:
      returnedColor = const Color(0xFF08CCFA);
      break;
    case PickClr.gkBGStyle1:
      returnedColor = const Color(0xFFfcfcfc);
      break;
    case PickClr.gkBGStyle2:
      returnedColor = const Color(0xFFF2F2F7);
      break;
    case PickClr.titleHeader:
      returnedColor = const Color(0xFFF5F5F5);
      break;
  }

  return returnedColor;
}

final bothBoxShadowV1 = [
  BoxShadow(
    color: Colors.black.withOpacity(0.15),
    offset: const Offset(0, -2),
    blurRadius: 2.5,
  ),
  BoxShadow(
    color: Colors.black.withOpacity(0.15),
    offset: const Offset(0, 2),
    blurRadius: 2.5,
  ),
];

final boxShadowV1 = <BoxShadow>[
  BoxShadow(
    color: Colors.black.withOpacity(0.15),
    offset: const Offset(1, 1.5),
    blurRadius: 1.5,
  ),
];

final boxShadowV2 = <BoxShadow>[
  BoxShadow(
    color: Colors.black.withOpacity(0.22),
    offset: const Offset(1, 1.5),
    blurRadius: 1.5,
  ),
];

final boxShadowV3 = <BoxShadow>[
  BoxShadow(
    color: Colors.black.withOpacity(0.22),
    offset: const Offset(1.5, 2),
    blurRadius: 2.5,
  ),
];

final boxShadowV4 = <BoxShadow>[
  BoxShadow(
    color: Colors.black.withOpacity(0.22),
    offset: const Offset(1.5, 2),
    blurRadius: 5,
  ),
];

final topBoxShadowV1 = <BoxShadow>[
  const BoxShadow(
    color: Colors.black,
    offset: Offset(-5, 5),
    blurRadius: 10,
  ),
];