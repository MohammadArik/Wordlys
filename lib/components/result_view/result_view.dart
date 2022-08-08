import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:wordlys/bloc/api_handler.dart';
import 'package:wordlys/components/result_view/meaning_block.dart';
import 'package:wordlys/components/result_view/sources_object.dart';
import 'package:wordlys/const/colors.dart';
import '../../models/word_data.dart';

class ResultView extends StatelessWidget {
  const ResultView();

  @override
  Widget build(BuildContext context) {
    var data = context.watch<APIHandler>().data;

    //? Check if loading
    if (data.state == DataState.Loading) {
      return Center(
        child: LoadingAnimationWidget.stretchedDots(
          color: const Color(HIGHLIGHT),
          size: 120,
        ),
      );
    }

    //? Check if the result is not found
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

    //? Check if the result is not found
    if (data.state == DataState.Error) {
      return Text(
        "Error loading results.\nPlease check your internet connection.",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color(PRIMARY_TEXT),
          fontSize: 15,
        ),
      );
    }

    //? If the data state is ready
    if (data.state == DataState.Ready) {
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

        meaningWidgets.add(
          MeaningBlock(
            definitions: definitions,
            antonyms: antonyms,
            synonyms: synonyms,
            partOfSpeech: partOfSpeech,
          ),
        );
      }

      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Click to copy the synonyms and antonyms!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            ...meaningWidgets, // MeaningObject(s)
            SourcesObject(sources: data.sources) // the sources object
          ],
        ),
      );
    }

    //? And lastly if data state is empty(which is default)
    return const SizedBox();
  }
}
