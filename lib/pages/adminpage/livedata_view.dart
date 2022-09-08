import 'dart:convert';

import 'package:feedback_view/data/feedbackdata.dart';
import 'package:feedback_view/datagram/data_packet.dart';
import 'package:feedback_view/services/network_api.dart';
import 'package:flutter/material.dart';

class LiveDataView extends StatelessWidget {
  final int vendorID;
  List<FeedbackData> list = [];
  LiveDataView({
    Key? key, required this.vendorID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 30,bottom: 20),
              child: Text(
                "LIVE DATA",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.blueGrey.shade600,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
        Expanded(
          child: StreamBuilder(
            initialData: "LOADING",
            stream: NetworkApi.getRealSse(vendorID),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasError || snapshot.connectionState==ConnectionState.done){
                return const Text("Connection Interrupted Or Closed");
              }
              else if(snapshot.connectionState==ConnectionState.waiting || (snapshot.data as String)=="LOADING"){
                return const Center(child: CircularProgressIndicator(color: Colors.black,));
              }
              else {

           
                list.add(FeedbackData.fromJson(jsonDecode(snapshot.data)));
                int count = (list.length<5)?(list.length):5;
                return ListView.builder(itemBuilder: (ctx, index) {
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 35),
                      child: DataPacket(feedbackData: list[index]));
                },itemCount: count,padding: const EdgeInsets.only(left: 50,right: 50),);

              }

            },
          ),
        ),
      ],
    );
  }
}
