import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordlys/const/colors.dart';

enum WordType { Synonym, Antonym }

class WordsSection extends StatelessWidget {
  const WordsSection({required this.wordList, required this.type});
  final List<dynamic> wordList;
  final WordType type;

  @override
  Widget build(BuildContext context) {
    final blockColorNum = type == WordType.Synonym ? HIGHLIGHT : 0xFF0957B7;

    List<Widget> wordsWidgetList = <Widget>[];
    for (var word in wordList) {
      wordsWidgetList.add(
        GestureDetector(
          onTap: (() {
            Clipboard.setData(ClipboardData(text: word));
          }),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: EdgeInsets.fromLTRB(0, 4, 8, 4),
            decoration: BoxDecoration(
                color: Color(blockColorNum),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Text(
              word,
              style: TextStyle(
                color: Color(0xFFF9F8FF),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      width: Size.infinite.width,
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFFF9F8FF),
        border: Border.all(
          color: Color(BORDER),
        ),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (type == WordType.Synonym ? "Synonyms" : "Antonyms"),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Wrap(
            children: wordsWidgetList,
          )
        ],
      ),
    );
  }
}
