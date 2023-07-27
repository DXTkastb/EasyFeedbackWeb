class FeedbackData {
  int _num; // y
  int _time; // y
  double? _sentimentScore; // y
  String? _category;
  String _feedback; // y
  int _vendorID;
  int _isInaccurate;
  List<Sentence> _positiveSentences;
  List<Sentence> _neutralSentences;
  List<Sentence> _negativeSentences;

  FeedbackData(
      this._num,
      this._time,
      this._sentimentScore,
      this._category,
      this._feedback,
      this._vendorID,
      this._isInaccurate,
      this._negativeSentences,
      this._neutralSentences,
      this._positiveSentences);

  factory FeedbackData.fromJson(dynamic json) {
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

    return FeedbackData(
        json["num"],
        json["time"],
        json["sentimentScore"],
        json["category"],
        json["feedback"],
        json["vendorID"],
        json["isInaccurate"],
        neutralList,
        neutralList,
        positiveList);
  }

  List<Sentence> get positiveSentences => _positiveSentences;

  int get isInaccurate => _isInaccurate;

  set isInaccurate(int value) {
    _isInaccurate = value;
  }

  int get vendorID => _vendorID;

  set vendorID(int value) {
    _vendorID = value;
  }

  String get feedback => _feedback;

  set feedback(String value) {
    _feedback = value;
  }

  String? get category => _category;

  set category(String? value) {
    _category = value;
  }

  double? get sentimentScore => _sentimentScore;

  set sentimentScore(double? value) {
    _sentimentScore = value;
  }

  int get time => _time;

  set time(int value) {
    _time = value;
  }

  int get num => _num;

  set num(int value) {
    _num = value;
  }

  @override
  String toString() {
    return "${_num} : ${_time}" + _feedback;
  }

  List<Sentence> get neutralSentences => _neutralSentences;

  List<Sentence> get negativeSentences => _negativeSentences;
}

class Sentence {
  TextSpan _text;
  Sentiment _sentiment;

  Sentence(this._text, this._sentiment);

  factory Sentence.fromjson(dynamic json) {
    return Sentence(
        TextSpan.fromJson(json["text"]), Sentiment.fromJson(json["sentiment"]));
  }

  Sentiment get sentiment => _sentiment;

  set sentiment(Sentiment value) {
    _sentiment = value;
  }

  TextSpan get text => _text;

  set text(TextSpan value) {
    _text = value;
  }
}

class Sentiment {
  double _score;
  double? _magnitude;

  Sentiment(this._score, this._magnitude);

  factory Sentiment.fromJson(dynamic json) {
    return Sentiment(json["score"], json["magnitude"]);
  }

  double? get magnitude => _magnitude;

  set magnitude(double? value) {
    _magnitude = value;
  }

  double get score => _score;

  set score(double value) {
    _score = value;
  }
}

class TextSpan {
  String _content;
  double? _beginOffset;

  TextSpan(this._content, this._beginOffset);

  factory TextSpan.fromJson(dynamic json) {
    return TextSpan(json["content"], json['beginOffset']);
  }

  double? get beginOffset => _beginOffset;

  set beginOffset(double? value) {
    _beginOffset = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }
}

class Vendor {
  String _vendorName;
  int _vendorID;

  Vendor(this._vendorName, this._vendorID);

  int get vendorID => _vendorID;

  set vendorID(int value) {
    _vendorID = value;
  }

  String get vendorName => _vendorName;

  set vendorName(String value) {
    _vendorName = value;
  }
}
