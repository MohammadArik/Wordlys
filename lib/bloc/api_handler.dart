import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/word_data.dart';

class APIHandler with ChangeNotifier {
  // The TextEditingController for handling input changes
  final TextEditingController textFieldController = TextEditingController();

  // The _reqLimitTimer to thorttle API calls
  Timer _reqLimitTimer = Timer(Duration(microseconds: 300), (() {}));

  // The variable to store WordData
  WordData _data = WordData();

  WordData get data => _data;

  // To store the last word handled
  String prevWord = "";
  // To store the current active request
  int reqID = 0;

  //? To dispose the controllers and remove listener
  @override
  void dispose() {
    textFieldController.removeListener(_listenToUpdates);
    textFieldController.dispose();
    super.dispose();
  }

  APIHandler() {
    textFieldController.addListener(_listenToUpdates);
    _updateState(DataState.Empty);
  }

  //? High level function to update state
  void _updateState(DataState state) {
    if (_data.state != state) {
      _data.state = state;
      notifyListeners();
    }
  }

  //? The function to handle userInputs
  void _listenToUpdates() {
    // Get the value
    var inputString = textFieldController.text;

    // Do nothing if the input hasn't changed
    if (inputString == prevWord) {
      return;
    }
    prevWord = inputString;

    // If 300ms not passed after the previous input cancel the previous _reqLimitTimer
    if (_reqLimitTimer.isActive) {
      _reqLimitTimer.cancel();
    }

    // return if the inputString is empty
    inputString = inputString.trim();
    if (inputString == "") {
      _updateState(DataState.Empty);
      return;
    }

    //  If the inputString contains space between words, automatically the show not found
    if (inputString.split(" ").length > 1) {
      _updateState(DataState.NotFound);
      return;
    }

    // Send the stream inform about loading-state
    _updateState(DataState.Loading);

    // Initialize the _reqLimitTimer to request after 300ms only if inputString is not empty
    reqID++;
    _reqLimitTimer = Timer(const Duration(milliseconds: 300), (() async {
      await _callAPIandParseData(inputString, reqID);
    }));
  }

  //? Function to request and parse data from the API
  Future<void> _callAPIandParseData(String word, int id) async {
    try {
      // Making the id final
      final rID = id;
      //* Request the api
      var url = Uri.https('api.dictionaryapi.dev', 'api/v2/entries/en/' + word);
      var res = await get(url);

      //* Check if this is the current request
      if (rID == this.reqID) {
        //* Validate the result
        // Check if the word was found or not
        if (res.statusCode == 404) {
          _updateState(DataState.NotFound);
          return;
        }
        if (res.statusCode == 200) {
          // parse the data
          var decodedResponse = jsonDecode(utf8.decode(res.bodyBytes))[0];

          // Update the data
          _data.meaningBlocksData =
              decodedResponse['meanings'] as List<dynamic>;
          _data.sources = decodedResponse['sourceUrls'] as List<dynamic>;
          _data.state = DataState.Ready;
          // notify the listeners about the change
          notifyListeners();
        } else {
          _updateState(DataState.Error);
        }
      }
    } catch (_) {
      _updateState(DataState.NotFound);
    }
  }
}
