import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  bool isIOS = false;
  bool isDarkView = false;
  String selectedDate = "Pick Date";
  String selectedTime = "Pick Time";

  changePlatform() {
    isIOS = !isIOS;
    notifyListeners();
  }

  changeTheme() {
    isDarkView = !isDarkView;
    notifyListeners();
  }

  setSelectedDate(DateTime selectedDate) {
    this.selectedDate = selectedDate.toString();
    notifyListeners();
  }

  setSelectedTime(TimeOfDay selectedTime) {
    this.selectedTime = selectedTime.toString();
    notifyListeners();
  }
}
