import 'package:flutter/material.dart';

class DataChange extends ChangeNotifier {

  bool isLive = false;

  void changeDataView(bool newData){
    isLive = newData;
    notifyListeners();
  }

}