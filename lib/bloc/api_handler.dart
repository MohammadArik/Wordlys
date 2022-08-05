import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// State of the
enum DataState { Empty, Loading, Ready, NotFound }

class WordData {
  DataState state = DataState.Empty;
  List<dynamic> wordData = <dynamic>[];
}

class APIHandler {
  // The TextEditingController for handling input changes
  final textFieldController = TextEditingController();

  // The StreamController to pass data
  final _dataStreamController = StreamController<WordData>();
  Stream<WordData> get getData => _dataStreamController.stream;

  // The _reqLimitTimer to thorttle API calls
  Timer _reqLimitTimer = Timer(Duration(microseconds: 300), (() {}));

  // The variable to store WordData
  WordData _data = WordData();

  // To store the last word handled
  String prevWord = "";

  //? To dispose the controllers and remove listener
  void dispose() {
    _dataStreamController.close();
    textFieldController.removeListener(_listenToUpdates);
    textFieldController.dispose();
  }

  //? the constructor function;
  APIHandler() {
    textFieldController.addListener(_listenToUpdates);
  }

  //? High level function to update state
  void _updateState(DataState state) {
    if (_data.state != state) {
      _data.state = state;
      _dataStreamController.sink.add(_data);
    }
  }

  //? Function to request and parse data from the API
  Future<void> _callAPIandParseData(String word) async {
    // try {
    //* Request the api
    var url = Uri.https('api.dictionaryapi.dev', 'api/v2/entries/en/' + word);
    var res = await get(url);

    //* Validate the result
    // Check if the word was found or not
    if (res.statusCode == 404) {
      _updateState(DataState.NotFound);
      return;
    }
    // parse the data
    var decodedResponse =
        jsonDecode(utf8.decode(res.bodyBytes))[0]['meanings'] as List<dynamic>;
    // print(decodedResponse);

    // Update the data
    _data.wordData = decodedResponse;
    _data.state = DataState.Ready;
    // Sink the data to the StreamController
    _dataStreamController.sink.add(_data);
    // } catch (_) {}
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
    _reqLimitTimer = Timer(const Duration(milliseconds: 300), (() async {
      await _callAPIandParseData(inputString);
    }));
  }
}
