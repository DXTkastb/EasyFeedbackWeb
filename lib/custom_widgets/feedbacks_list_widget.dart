import 'package:feedback_view/datagram/data_packet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/newfeedbackdata.dart';
import '../providers/vendor_feedback_provider.dart';
import 'feedback_loading_widget.dart';

class FeedBackListWidget extends StatelessWidget {
  const FeedBackListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<VendorFeedbackProvider>(
      builder: (ctx, vfp, wid) {
        return FutureBuilder(
          future: vfp.loadingDataFuture,
          builder: (BuildContext futureCtx, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if(vfp.data.isEmpty) return const Center(child: Text('No feedbacks as of yet.'),);
              return NotificationListener<ScrollEndNotification>(
                onNotification: (notification) {
                  if(notification.metrics.extentAfter <= 30) {
                    vfp.loadOldData();
                  }
                  return true;
                },
                child: ListView.builder(
                    padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                    itemCount:
                        (vfp.canLoadMore) ? vfp.data.length + 1 : vfp.data.length,
                    itemBuilder: (ctx, index) {
                      if (index == vfp.data.length) {
                        return const FeedbackLoadingWidget();
                      }
                      return DataPacket(feedbackData: vfp.data[index]);
                    }),
              );
            }

            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          },
        );
      },
    );
  }
}
