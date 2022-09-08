import 'package:feedback_view/provider_dict/data_change.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database_view.dart';
import 'livedata_view.dart';

class AdminPage extends StatelessWidget {
  final int vendorID;
  const AdminPage({Key? key, required this.vendorID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataChange>(
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
      builder: (BuildContext consumerContext, value, Widget? child) {
        if (value.isLive) {
          return  LiveDataView(vendorID: vendorID,);
        }
        return   StaticData(vendorID: vendorID,);
          // DataView1(vendorID: vendorID,);
      },
    );
  }
}



