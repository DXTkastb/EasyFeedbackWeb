import 'dart:async';

import 'package:flutter/material.dart';

class FeedbackLoadingWidget extends StatefulWidget {
  const FeedbackLoadingWidget({super.key});

  @override
  State<FeedbackLoadingWidget> createState() => _FeedbackLoadingWidgetState();
}

class _FeedbackLoadingWidgetState extends State<FeedbackLoadingWidget> {
  static const List<String> strings = [
    '.',
    '..',
    '...',
  ];
  int index = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
      if (mounted)
        setState(() {
          index++;
          index = index % 3;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      strings[index],
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.black, fontSize: 35, fontWeight: FontWeight.w900),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
}
