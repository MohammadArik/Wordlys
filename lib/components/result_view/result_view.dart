import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wordlys/bloc/api_handler.dart';
import 'package:wordlys/components/result_view/meaning_block.dart';
import 'package:wordlys/components/result_view/sources_object.dart';
import 'package:wordlys/const/colors.dart';

class ResultView extends StatelessWidget {
  const ResultView({required this.apiHandler});
  final APIHandler apiHandler;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: window.physicalSize.width,
        color: Color(PRIMARY),
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: StreamBuilder<WordData>(
          stream: apiHandler.getData,
          builder: ((context, snapshot) {
            var data = snapshot.data;

            if (data != null && data.state != DataState.Empty) {
              //* Check if loading
              if (data.state == DataState.Loading) {
                return Center(
                  child: LoadingAnimationWidget.stretchedDots(
                    color: Color(HIGHLIGHT),
                    size: 120,
                  ),
                );
              }

              //* Check if the result is not found
              if (data.state == DataState.NotFound) {
                return Text(
                  "Can't find any results.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(PRIMARY_TEXT),
                    fontSize: 15,
                  ),
                );
              }

              //* It is now surely ready
              // Parse the meaning-data and create MeaningBlock(s)
              var meaningWidgets = <Widget>[];

              for (var meaningBlock in data.meaningBlocksData) {
                var partOfSpeech = meaningBlock["partOfSpeech"] as String;
                var synonyms = meaningBlock["synonyms"] as List<dynamic>;
                var antonyms = meaningBlock["antonyms"] as List<dynamic>;

                var definitions = <String>[];
                for (var definition in meaningBlock["definitions"]) {
                  definitions.add(definition["definition"] as String);
                }

                meaningWidgets.add(MeaningBlock(
                    definitions: definitions,
                    antonyms: antonyms,
                    synonyms: synonyms,
                    partOfSpeech: partOfSpeech));
              }

              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Click to copy the synonyms and antonyms!",
                      softWrap: false,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...meaningWidgets, // MeaningObject(s)
                    SourcesObject(sources: data.sources)
                  ],
                ),
              );
            }

            return SizedBox();
          }),
        ),
      ),
    );
  }
}
