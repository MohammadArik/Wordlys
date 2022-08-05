import 'package:flutter/material.dart';
import 'package:wordlys/const/colors.dart';

class MeaningBlock extends StatefulWidget {
  const MeaningBlock({Key? key}) : super(key: key);

  @override
  State<MeaningBlock> createState() => _MeaningBlockState();
}

class _MeaningBlockState extends State<MeaningBlock> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        border: Border.all(
          color: Color(BORDER),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(12, 6, 12, 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border.all(
                    color: Color(HIGHLIGHT),
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                child: Text(
                  "noun",
                  style: TextStyle(
                    color: Color(HIGHLIGHT),
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(child: SizedBox()), // spacing to push button to the side
              IconButton(
                onPressed: (() {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                }),
                icon: isExpanded
                    ? Image.asset(
                        "assets/images/downArrow.png",
                        width: 18,
                      )
                    : Image.asset(
                        "assets/images/upArrow.png",
                        width: 18,
                      ),
                color: Color(BORDER),
                splashColor: Color(BORDER),
                padding: EdgeInsets.all(4),
              ),
            ],
          ),
          isExpanded
              ? Column(
                  children: [
                    SizedBox(height: 8),
                    wordsSection([
                      "Word 1",
                      "Word 2",
                      "Word 3",
                      "Word 4",
                    ], WordType.Synonym),
                    SizedBox(height: 8),
                    wordsSection([
                      "Word 1",
                      "Word 2",
                      "Word 3",
                      "Word 4",
                    ], WordType.Antonym)
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}

enum WordType { Synonym, Antonym }

Widget wordsSection(List<String> wordList, WordType type) {
  final blockColorNum = type == WordType.Synonym ? HIGHLIGHT : 0xFF0957B7;

  List<Widget> wordsWidgetList = <Widget>[];
  for (var word in wordList) {
    wordsWidgetList.add(
      Container(
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
    );
  }

  return Container(
    width: Size.infinite.width,
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
            fontWeight: FontWeight.w500,
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
