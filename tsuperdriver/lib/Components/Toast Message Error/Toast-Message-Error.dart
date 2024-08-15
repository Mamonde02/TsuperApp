import 'package:flutter/material.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import 'styled_toast.dart' show showToast1, showToastWidget1, StyledToast1;
import 'styled_toast_enum.dart';
// import 'custom_size_transition.dart';

import '../Colors-Design.dart';

class ToastMessageError {
  static void errorMessage(String error, BuildContext context) {
    showToast1(error,
      fullWidth: true,
      textPadding: const EdgeInsets.only(
        bottom: 20,
      ),
      context: context,
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.slideFromTopFade,
      position: const StyledToastPosition1(align: Alignment.bottomCenter, offset: 370),
      startOffset: const Offset(0.0, -3.0),
      reverseEndOffset: const Offset(0.0, -3.0),
      duration: const Duration(seconds: 2),
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastOutSlowIn
    );
  }

  static void errorMessageV2(
    String error, 
    BuildContext context,  
    {
      double offSetBy = 0.0,
      StyledToastPosition1 position = const StyledToastPosition1(align: Alignment.bottomCenter, offset: 0.0),
      bool isShapedBorder = true,
      Color? bgColor = Colors.white
    }) async {
    showToast1(error,
      textPadding: EdgeInsets.only(top: isShapedBorder ? 0 : 20, bottom: 20, left: 35, right: 35),
      textStyle: TextStyle(color: bgColor == Colors.white? Colors.black : Colors.white),
      context: context,
      animation: StyledToastAnimation.slideToBottomFade,
      position: position,
      startOffset: const Offset(0.0, -3.0),
      reverseEndOffset: const Offset(0.0, -3.0),
      duration: const Duration(seconds: 4),
      animDuration: const Duration(seconds: 2),
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastOutSlowIn,
      backgroundColor: bgColor,
      isHaveBoxShadow: true
    );
  }

  static void displayOverlayMEssage(
    String label,
    BuildContext context,
    {
      double offSetBy = 0.0,
      StyledToastPosition1 position = const StyledToastPosition1(align: Alignment.bottomCenter, offset: 0.0),
      bool isShapedBorder = true
    }) async {
    showToast1(
      label,
      textPadding: const EdgeInsets.only(top: 20, bottom: 35, left: 35, right: 35),
      textStyle: const TextStyle(color: Colors.white),
      context: context,
      animation: StyledToastAnimation.slideToBottomFade,
      position: position,
      startOffset: const Offset(0.0, -3.0),
      reverseEndOffset: const Offset(0.0, -3.0),
      duration: const Duration(seconds: 5),
      animDuration: const Duration(seconds: 2),
      curve: Curves.fastLinearToSlowEaseIn,
      reverseCurve: Curves.fastOutSlowIn,
      backgroundColor: gkGetColor(PickClr.gkSkyBlue),
      isHaveBoxShadow: true,
    );
  }
}
