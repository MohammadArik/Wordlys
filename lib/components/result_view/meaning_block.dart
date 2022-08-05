import 'package:flutter/material.dart';
import 'package:wordlys/components/result_view/words_section.dart';
import 'package:wordlys/const/colors.dart';
import 'definition_object.dart';

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
      margin: EdgeInsets.symmetric(vertical: 10),
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
                    fontSize: 16,
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
                    const WordsSection(
                      wordList: [
                        "Word 1",
                        "Word 2",
                        "Word 3",
                        "Word 4",
                      ],
                      type: WordType.Synonym,
                    ),
                    const WordsSection(
                      wordList: [
                        "Word 1",
                        "Word 2",
                        "Word 3",
                        "Word 4",
                      ],
                      type: WordType.Antonym,
                    ),
                    DefinitionObject(
                      definition: "lorem ipsum dolor sit amet benir upit",
                    ),
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}
