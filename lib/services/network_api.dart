import 'dart:async';
import 'dart:convert';

import 'package:feedback_view/data/newfeedbackdata.dart';
import 'package:feedback_view/services/storage_service.dart';
import 'package:http/http.dart' as http;

import '../data/feedbackdata.dart';
import '../data/userdata.dart';

class NetworkApi {
  static const String fetchFeedbackUri =
      'http://localhost:8080/vendor/feedbacks?lastid=';

  // static SseClient? sseClient;

  static Future<UserLoggedInData?> authUser(
    int vendorid,
  ) async {
    http.Response response = await http.get(
        Uri.parse(
          'http://localhost:8080/vendor/auth/$vendorid',
        ),
        headers: {
          "Access-Control-Allow-Origin": "*",
          // Required for CORS support to work
          "Access-Control-Allow-Headers": "*",
        }).onError((error, stackTrace) => http.Response("", 503));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return UserLoggedInData(data["vendorID"], data["vendorName"]);
    }
    return null;
  }

  static Future<int> vendorCreate(int newID, String name) async {
    Vendor vendor = Vendor(name, newID);
    Map<String, dynamic> map = {"vendorName": name, "vendorID": newID};
    var response = await http
        .post(Uri.parse("http://localhost:8080/vendor/createvendor"),
            headers: {
              "Content-type": "application/json",
              "Access-Control-Allow-Origin": "*",
              // Required for CORS support to work
              "Access-Control-Allow-Headers": "*",
            },
            body: jsonEncode(map))
        .onError((error, stackTrace) {
      return http.Response("", 404);
    });
    if (response.statusCode == 202) {
      return 0;
    } else if (response.statusCode == 400) {
      return 1;
    }
    return 2;

    // already exists return 1
    // network error return 2
  }

  static Future<List<FeedbackData>> getFeedbackData(
      int numberOfOrders, int vendorid) async {
    List<FeedbackData> list = [];
    var response = await http.get(
        Uri.parse(
            "http://localhost:8080/vendor/$vendorid/db?numRecords=$numberOfOrders"),
        headers: {
          "Access-Control-Allow-Origin": "*",
          // Required for CORS support to work
          "Access-Control-Allow-Headers": "*",
        }).onError((error, stackTrace) => http.Response("", 404));

    if (response.statusCode != 200) {
      return List<FeedbackData>.empty();
    }

    List<dynamic> dataFetched = jsonDecode(response.body);
    for (var element in dataFetched) {
      list.add(FeedbackData.fromJson(element));
    }
    return list;
  }

  // static Stream? getRealSse(int vendorID) {
  //   try {
  //     sseClient = SseClient(
  //         "http://localhost:8080/vendor/sse?vendorID=$vendorID");
  //   } catch (e) {
  //     sseClient = null;
  //     return const Stream.empty();
  //   }
  //   return sseClient!.stream;
  // }
  //
  // static void closeSseClient(){
  //   if(sseClient!=null) sseClient!.close();
  // }

/*
  ______________________NEW API_________________________
 */

  static Future<List<NewFeedbackData>> getData(int lastId) async {
    var token = StorageService.service.getKey();
    var response =
        await http.get(Uri.parse('$fetchFeedbackUri$lastId'), headers: {
      'auth-token': token ?? '',
      "Access-Control-Allow-Origin": "*",
      // Required for CORS support to work
      "Access-Control-Allow-Headers": "*",
    }).onError((error, stackTrace) {
      print('error occurred!!');
      return http.Response("", 404);
    });

    List<NewFeedbackData> list = [];
    // [newFeedbackData, newFeedbackData];
    if (response.statusCode != 200) {
      return list;
    }
    List<dynamic> dataFetched = jsonDecode(response.body);
    for (var element in dataFetched) {
      list.add(NewFeedbackData.fromJson(element));
    }
    return list;
  }
}
