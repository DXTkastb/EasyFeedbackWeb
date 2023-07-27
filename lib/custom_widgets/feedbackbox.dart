import 'package:flutter/material.dart';

import '../data/feedbackdata.dart';

class FeedBackBox extends StatelessWidget{
  final int type;
  final List<Sentence> list;
  const FeedBackBox({super.key, required this.type, required this.list});

  Color getBackGroundColor(){
    if(type==-1) return Color.fromRGBO(253, 198, 200, 1.0);
    if(type == 1) return Color.fromRGBO(176, 238, 201, 1.0);
    return Color.fromRGBO(194, 218, 255, 1.0);
  }
  Color getBackGroundColorForIcon(){
    if(type==-1) return Color.fromRGBO(255, 126, 133, 1.0);
    if(type == 1) return Color.fromRGBO(107, 199, 141, 1.0);
    return Color.fromRGBO(115, 153, 215, 1.0);
  }

  List<Widget> getFeedbacks() {
    return list.map((e) => Row(
      children: [
      Icon(Icons.circle,color: getBackGroundColorForIcon(),size: 8,),
      const SizedBox(width: 3,),
      Flexible(child: Text(e.text.content,style: const TextStyle(fontWeight: FontWeight.w500),))],)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      elevation: 0,
      margin: const EdgeInsets.all(2),
      color: getBackGroundColor(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: getFeedbacks(),
        ),
      ),
    );
  }
}