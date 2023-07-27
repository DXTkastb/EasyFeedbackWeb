import 'feedbackdata.dart';

class NewFeedbackData {
  final int feedback_id;
  final String time;
  final double score;
  final int inaccurate;
  final String feedback;
  final List<Sentence> _positiveSentences;
  final List<Sentence> _neutralSentences;
  final List<Sentence> _negativeSentences;

  NewFeedbackData(
      this.feedback_id,
      this.time,
      this.score,
      this.inaccurate,
      this.feedback,
      this._positiveSentences,
      this._neutralSentences,
      this._negativeSentences);

  factory NewFeedbackData.fromJson(dynamic json) {
    List<dynamic> negatives = json["negativeSentences"];
    List<dynamic> positives = json["positiveSentences"];
    List<dynamic> neutrals = json["neutralSentences"];

    List<Sentence> positiveList = [];
    List<Sentence> negativeList = [];
    List<Sentence> neutralList = [];

    for (var element in negatives) {
      Sentence newSentence = Sentence.fromjson(element);
      negativeList.add(newSentence);
    }

    for (var element in positives) {
      Sentence newSentence = Sentence.fromjson(element);
      positiveList.add(newSentence);
    }

    for (var element in neutrals) {
      Sentence newSentence = Sentence.fromjson(element);
      neutralList.add(newSentence);
    }

    return NewFeedbackData(
        json['feedback_id'],
        json['time'],
        json['score'],
        json['inaccurate'],
        json['feedback'],
        positiveList,
        neutralList,
        negativeList);
  }

  static NewFeedbackData getDum(){
    return NewFeedbackData(4, '4 may 2012', 0.6, 0, 'HOlA!', [], [], []);
  }

  List<Sentence> get negativeSentences => _negativeSentences;

  List<Sentence> get neutralSentences => _neutralSentences;

  List<Sentence> get positiveSentences => _positiveSentences;
}
