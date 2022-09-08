import 'package:feedback_view/datagram/data_packet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/data/feedbackdata.dart';
import '/services/network_api.dart';

class StaticData extends StatefulWidget {
  final int vendorID;

  const StaticData({Key? key, required this.vendorID}) : super(key: key);

  @override
  State<StaticData> createState() => _DataView1State();
}

class _DataView1State extends State<StaticData> {
  int numberOfOrders = 10;
  late String time;
  late Future future;

  @override
  void initState() {
    future = NetworkApi.getFeedbackData(numberOfOrders, widget.vendorID);
    time = "[${DateFormat.yMd().add_jm().format(DateTime.now())}]";
    super.initState();
  }

  void reloadOrdersNumbers(int numbers) {
    future = NetworkApi.getFeedbackData(numberOfOrders, widget.vendorID);
    numberOfOrders = numbers;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            Text(
              "DATABASE",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.blueGrey.shade600,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              "LAST UPDATE :  $time",
              style: const TextStyle(fontSize: 12),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            TextButton.icon(
              onPressed: () {
                // call to database

                setState(() {
                  future = NetworkApi.getFeedbackData(
                      numberOfOrders, widget.vendorID);
                  time =
                      "[${DateFormat.yMd().add_jm().format(DateTime.now())}]";
                });
              },
              label: const Text("RELOAD"),
              icon: const Icon(
                Icons.refresh,
                color: Colors.blue,
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.only(
                      top: 13, bottom: 13, left: 8, right: 8))),
            ),
            const SizedBox(
              width: 10,
            ),
            CustomDropDown(
              reloadfunction: reloadOrdersNumbers,
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: FutureBuilder(
            future: future,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<FeedbackData> data = snapshot.data as List<FeedbackData>;

                return ListView(
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  children: [
                    ...data.map((e) {
                      return Container(
                          decoration: const BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 8,
                                spreadRadius: 0.5,
                                offset: Offset(0, 1))
                          ]),
                          margin: const EdgeInsets.only(
                              bottom: 35, left: 10, right: 10),
                          child: DataPacket(feedbackData: e));
                    }).toList()


                  ],
                );
              }

              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

class CustomDropDown extends StatefulWidget {
  final void Function(int numbers) reloadfunction;

  const CustomDropDown({Key? key, required this.reloadfunction})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  int selected = 10;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
        underline: null,
        icon: null,
        value: selected,
        items: <int>[
          5,
          10,
          20,
        ].map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text("$value"),
          );
        }).toList(),
        onChanged: (int? newSelected) {
          setState(() {
            widget.reloadfunction(newSelected!);
            selected = newSelected!;
          });
        });
  }
}
