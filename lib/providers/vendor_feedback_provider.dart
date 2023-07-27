import 'dart:js_util';

import 'package:feedback_view/data/newfeedbackdata.dart';
import 'package:feedback_view/services/network_api.dart';
import 'package:flutter/material.dart';

class VendorFeedbackProvider extends ChangeNotifier {
  bool disposed = false;
  bool canLoadMore = true;
  bool loadingPrevious = false;
  bool reloading = true;
  List<NewFeedbackData> data = [];
  late Future loadingDataFuture;

  VendorFeedbackProvider() {
    initFuture();
  }

  void initFuture() {
    reloading = true;
    loadingDataFuture = loadData();
  }

  Future loadData() async {
    if(disposed) return;
    await Future.delayed(const Duration(seconds: 2));
    List<NewFeedbackData> newData = await NetworkApi.getData(0);
    if(disposed) return;
    data = newData;
    if(newData.length < 20) canLoadMore = false;
    reloading = false;
    notifyListeners();
  }

  void reload(){
    if(disposed) return;
    initFuture();
    notifyListeners();
  }

  void loadOldData() async {
    if(disposed || loadingPrevious || reloading) return;
    loadingPrevious = true;
    await Future.delayed(const Duration(seconds: 3));
    List<NewFeedbackData> olddata = await NetworkApi.getData(data.last.feedback_id);
    if(olddata.length < 50) canLoadMore = false;
    data.addAll(olddata);
    if(disposed) return;
    loadingPrevious = false;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    disposed = true;
  }
}
