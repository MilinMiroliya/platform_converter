import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier{
  bool isIOS = true;

  changePlatform(){
    isIOS = !isIOS;
    notifyListeners();
  }
}