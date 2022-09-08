import 'package:feedback_view/data/feedbackdata.dart' hide TextSpan;
import 'package:flutter/material.dart';

class DataPacket extends StatelessWidget {
  final FeedbackData feedbackData;

  const DataPacket({Key? key, required this.feedbackData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var normalizedScore = (5) * ((feedbackData.sentimentScore! + 1) / 2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade100,
            border: const Border(
                left: BorderSide(width: 6, color: Colors.blueGrey)),
          ),
          padding: const EdgeInsets.only(left: 8, bottom: 10, top: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: "ORDER-NUMBER :  ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(55, 71, 79, 1)),
                        ),
                        TextSpan(
                          text: "${feedbackData.num}${feedbackData.time}",
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 17,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Text("Rating: $normalizedScore/5"),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    (normalizedScore < 2.5)
                        ? Icons.thumb_down_alt_sharp
                        : Icons.thumb_up_alt_sharp,
                    color: (normalizedScore >= 2.5)
                        ? Colors.green
                        : Colors.redAccent,
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                feedbackData.feedback,
                style: const TextStyle(
                    color: Color.fromRGBO(55, 71, 79, 1),
                    fontSize: 17,
                    fontWeight: FontWeight.w900),
              )
            ],
          ),
        ),
        ...feedbackData.sentences!.map((e) {
          return SentenceWidget(
              sentence: e.text.content, positive: (e.sentiment.score >= 0));
        }).toList(),
      ],
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
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: (positive) ? Colors.green.shade100 : Colors.red.shade100,
        border: Border(
            left: BorderSide(
                width: 6, color: (positive) ? Colors.green : Colors.redAccent)),
      ),
      padding: const EdgeInsets.only(left: 8, top: 5, bottom: 5, right: 8),
      child: Text(
        sentence,
        style: const TextStyle(fontSize: 15.3),
      ),
    );
  }
}
