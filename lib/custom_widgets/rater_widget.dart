import 'package:flutter/material.dart';

class RaterWidget extends StatelessWidget {
  final double score;

  const RaterWidget({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    var normalizedScore = (5) * ((score + 1) / 2);
    return Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(248, 213, 157, 1.0),
          borderRadius: BorderRadius.circular(5)
        ),
        child: Text("${normalizedScore.toStringAsFixed(2)} / 5"));
  }
}
