// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:tsuperdriver/Components/Colors-Design.dart';
// import 'package:tsuperdriver/Components/CommonFunc.dart';
// import 'package:tsuperdriver/Controller/1.%20CommonUI/BackNavigation.dart';

// import '../../../Components/GlobalVar.dart';
// import '../../../Model/MatchModel.dart';
// import '../../../Server/Repo.dart';


// class FirebaseEmailVerification extends StatefulWidget {
//   String email = "";
//   Map<String, dynamic> legalInfo;

//   FirebaseEmailVerification({
//     super.key,
//     required this.email,
//     required this.legalInfo
//   });
  
//   @override
//   State<StatefulWidget> createState() => _FirebaseEmailVerification();
// }

// class _FirebaseEmailVerification extends State<FirebaseEmailVerification> {
//   bool isVerified = false;
//   Timer? timer;

//   @override
//   void initState() {
//     timer = Timer.periodic(const Duration(seconds: 3), (timer) { 
//       checkEmailVerificaton();
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const style1 =  TextStyle(fontFamily: "SF-Pro-Round-Medium", color: Color(0xFF434343), fontSize: 17);
//     const style2 =  TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w700);

//     return
//     PopScope(
//       canPop: false,
//       child: AlertDialog(
//         contentPadding: EdgeInsets.zero,
//         elevation: 7,
//         backgroundColor: Colors.white,
//         content: IntrinsicHeight(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Container(width: 10),
//                 const Center(
//                   child: SizedBox(
//                     width: 55, height: 55,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 10,
//                       color: Colors.orange,
//                       strokeCap: StrokeCap.round,
//                     ),
//                   ),
//                 ),
              
//                 spacer(15),
//                 Text("Please verify your email.\nWe have send email verification to ${widget.email}",
//                   style: style1,
//                   textAlign: TextAlign.center,
//                 ),

//                 spacer(25),
//                 MaterialButton(
//                   color: gkGetColor(PickClr.tsuperTheme),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
//                   elevation: 2,
//                   onPressed: () async {
//                     try {
//                       await FirebaseAuth.instance.currentUser!.delete();
//                       if (!mounted) return;
//                       Navigator.of(context).pop();
//                     } catch(signUpError) {
//                       print(signUpError);
//                     }
//                   },
//                   child: 
//                   const Text("Cancel", style: style2),
//                 )
//               ],
//             ),
//           ),
//         )
//       ),
//     );
//   }

//   Future checkEmailVerificaton() async {
//     await FirebaseAuth.instance.currentUser!.reload();
//     setState(() {
//       isVerified = FirebaseAuth.instance.currentUser!.emailVerified;
//       if (isVerified) {
//         Navigator.of(context).pop("Verified");
//       }
//     });
//   }
// }