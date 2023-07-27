import 'package:feedback_view/custom_widgets/feedbackbox.dart';
import 'package:feedback_view/custom_widgets/rater_widget.dart';
import 'package:feedback_view/data/newfeedbackdata.dart';
import 'package:flutter/material.dart';

class DataPacket extends StatelessWidget {
  final NewFeedbackData feedbackData;

  const DataPacket({Key? key, required this.feedbackData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var normalizedScore = (5) * ((feedbackData.score + 1) / 2);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,),
      margin: const EdgeInsets.only(bottom: 25, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //  mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:
                const EdgeInsets.only(left: 8, bottom: 10, top: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(155, 212, 252, 1.0),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: "feedback-id :  ",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(55, 71, 79, 1)),
                            ),
                            TextSpan(
                              text: "${feedbackData.feedback_id}",
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    RaterWidget(score: feedbackData.score),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  feedbackData.feedback,
                  style: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1.0),
                      fontSize: 15,
                      fontWeight: FontWeight.w900),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          (feedbackData.positiveSentences.isNotEmpty)
              ? FeedBackBox(
                  type: 1,
                  list: feedbackData.positiveSentences,
                )
              : const SizedBox(),
          (feedbackData.neutralSentences.isNotEmpty)
              ? FeedBackBox(
                  type: 0,
                  list: feedbackData.neutralSentences,
                )
              : const SizedBox(),
          (feedbackData.negativeSentences.isNotEmpty)
              ? FeedBackBox(
                  type: -1,
                  list: feedbackData.negativeSentences,
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class SentenceWidget extends StatelessWidget {
  final String sentence;
  final bool positive;

  const SentenceWidget(
      {Key? key, required this.sentence, required this.positive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      color: (positive)
          ? const Color.fromRGBO(183, 255, 219, 1.0)
          : const Color.fromRGBO(255, 204, 220, 1.0),
      child: Text(sentence),
    );
  }
}
