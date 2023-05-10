import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier {
  bool isIOS = true;
  bool isDarkView = false;
  String selectedDate = "";
  String selectedTime = "";

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
