import 'package:flutter/material.dart';
import 'package:wordlys/components/result_view/words_section.dart';
import 'package:wordlys/const/colors.dart';
import 'definition_object.dart';

class MeaningBlock extends StatefulWidget {
  final List<String> definitions;
  final List<dynamic> synonyms;
  final List<dynamic> antonyms;
  final String partOfSpeech;

  const MeaningBlock(
      {required this.definitions,
      required this.antonyms,
      required this.synonyms,
      required this.partOfSpeech});

  @override
  State<MeaningBlock> createState() => _MeaningBlockState();
}

class _MeaningBlockState extends State<MeaningBlock> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    var definitionObjects = <Widget>[];

    for (var definition in widget.definitions) {
      definitionObjects.add(DefinitionObject(definition: definition));
    }

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
                  widget.partOfSpeech,
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
                    widget.synonyms.length > 0
                        ? WordsSection(
                            wordList: widget.synonyms,
                            type: WordType.Synonym,
                          )
                        : SizedBox(),
                    widget.antonyms.length > 0
                        ? WordsSection(
                            wordList: widget.antonyms,
                            type: WordType.Antonym,
                          )
                        : SizedBox(),
                    ...definitionObjects, // Definition objects
                  ],
                )
              : SizedBox()
        ],
      ),
    );
  }
}
