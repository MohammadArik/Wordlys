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
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border.all(
          color: const Color(BORDER),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(12, 6, 12, 8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  border: Border.all(
                    color: Color(HIGHLIGHT),
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                child: Text(
                  widget.partOfSpeech,
                  style: const TextStyle(
                    color: Color(HIGHLIGHT),
                    fontSize: 16,
                  ),
                ),
              ),
              const Expanded(
                  child: SizedBox()), // spacing to push button to the side
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
                color: const Color(BORDER),
                splashColor: const Color(BORDER),
                padding: const EdgeInsets.all(4),
              ),
            ],
          ),
          isExpanded
              ? Column(
                  children: [
                    widget.synonyms.isNotEmpty
                        ? WordsSection(
                            wordList: widget.synonyms,
                            type: WordType.Synonym,
                          )
                        : const SizedBox(),
                    widget.antonyms.isNotEmpty
                        ? WordsSection(
                            wordList: widget.antonyms,
                            type: WordType.Antonym,
                          )
                        : const SizedBox(),
                    ...definitionObjects, // Definition objects
                  ],
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
