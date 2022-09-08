import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sse_client/sse_client.dart';

import '../data/feedbackdata.dart';
import '../data/userdata.dart';

class NetworkApi {
  static Future<UserLoggedInData?> authUser(
    int vendorid,
  ) async {
    http.Response response = await http
        .get(
          Uri.parse(
            // 'http://192.168.29.136:8080/vendor/auth/$vendorid',
            'url',
          ),
        )
        .onError((error, stackTrace) => http.Response("", 503));
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
        .post(Uri.parse(
                // "http://192.168.29.136:8080/vendor/createvendor"
                'url'),
            headers: {
              "Content-type": "application/json",
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
    var response = await http.get(Uri.parse(
        // "http://192.168.29.136:8080/vendor/$vendorid/db?numRecords=$numberOfOrders"
        'url')).onError((error, stackTrace) => http.Response("", 404));

    if (response.statusCode != 200) {
      return List<FeedbackData>.empty();
    }
    List<dynamic> dataFetched = jsonDecode(response.body);
    for (var element in dataFetched) {
      list.add(FeedbackData.fromJson(element));
    }
    return list;
  }

  static Stream? getRealSse(int vendorID) {
    SseClient? client;
    try {
      client = SseClient.connect(Uri.parse(
          // "http://192.168.29.136:8080/vendor/sse?vendorID=$vendorID"
          'url'));
    } catch (e) {
      return const Stream.empty();
    }
    return client!.stream;
  }
}
