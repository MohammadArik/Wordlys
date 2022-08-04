import 'dart:async';
import 'package:flutter/material.dart';

// State of the
enum DataState { Empty, Loading, Ready, NotFound }

class WordData {
  DataState state = DataState.Empty;
  var mainWord = "";
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
  WordData data = WordData();

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

  //? The function to handle userInputs
  void _listenToUpdates() {
    // Get the value
    var inputString = textFieldController.text;

    // If 300ms not passed after the previous input cancel the previous _reqLimitTimer
    if (_reqLimitTimer.isActive) {
      _reqLimitTimer.cancel();
    }

    // return if the inputString is empty
    inputString = inputString.trim();
    if (inputString == "") {
      return;
    }

    //  If the inputString contains space between words, automatically the show not found
    if (inputString.split(" ").length > 1) {
      if (data.state != DataState.NotFound) {
        data.state = DataState.NotFound;
        _dataStreamController.sink.add(data);
      }
      return;
    }

    // Send the stream inform about loading-state
    if (data.state != DataState.Loading) {
      data.state = DataState.Loading;
      _dataStreamController.sink.add(data);
    }

    // Initialize the _reqLimitTimer to request after 300ms only if inputString is not empty
    _reqLimitTimer = Timer(const Duration(milliseconds: 300), (() {
      // Request the api
      // Validate the result
      // Update the data
      data.mainWord = inputString;
      data.state = DataState.Ready;
      // Sink the data to the StreamController
      _dataStreamController.sink.add(data);
    }));
  }
}