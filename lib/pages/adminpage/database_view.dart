import 'package:feedback_view/custom_widgets/feedbacks_list_widget.dart';
import 'package:feedback_view/data/newfeedbackdata.dart';
import 'package:feedback_view/datagram/data_packet.dart';
import 'package:feedback_view/extras/styles.dart';
import 'package:feedback_view/providers/vendor_feedback_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../services/network_api.dart';
import '/data/feedbackdata.dart';

class StaticData extends StatefulWidget {
  final int vendorID;

  const StaticData({Key? key, required this.vendorID}) : super(key: key);

  @override
  State<StaticData> createState() => _DataView1State();
}

class _DataView1State extends State<StaticData> {
  // int numberOfOrders = 10;
  late String time;

  @override
  void initState() {
    time = "[${DateFormat.yMd().add_jm().format(DateTime.now())}]";
    super.initState();
  }

  // void reloadOrdersNumbers(int numbers) {
  //   future = NetworkApi.getFeedbackData(numberOfOrders, widget.vendorID);
  //   numberOfOrders = numbers;
  // }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
              "FEEDBACKS",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.blueGrey.shade600,
                  fontWeight: FontWeight.w900),
            ),
            const Expanded(
              child: SizedBox(),
            ),

          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Expanded(
          child: FeedBackListWidget()
        )
      ],
    );
  }
}
