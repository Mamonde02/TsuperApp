import 'package:crypto/crypto.dart';
import 'dart:convert';

extension StringExt on String {
  bool isEmailValid(){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }

  String getSha1() {
    var string = this;
    return sha1.convert(utf8.encode(string)).toString();
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String getSuffix(int fromIndex){
    if (length > fromIndex){
      return substring(length - fromIndex);
    }else{
      return "";
    }
  }
}