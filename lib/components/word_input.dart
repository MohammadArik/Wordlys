import 'dart:async';

import 'package:flutter/material.dart';

class WordInput extends StatefulWidget {
  const WordInput({Key? key}) : super(key: key);

  @override
  State<WordInput> createState() => _WordInputState();
}

class _WordInputState extends State<WordInput> {
  var inputString = "";
  var requestString = "";

  Timer timer = Timer(Duration(microseconds: 200), (() {}));

  void handleInput(String value) {
    // Update the value
    inputString = value;

    // If 200ms not passed after the previous input cancel the previous timer
    if (timer.isActive) {
      timer.cancel();
    }
    // return if the inputString is empty
    inputString = inputString.trim();
    if (inputString == "" && requestString != "") {
      setState(() {
        requestString = "";
      });
      return;
    }

    // Set the state to loading
    if (requestString != "loading") {
      setState(() {
        requestString = "loading";
      });
    }
    // Initialize the timer to request after 200ms only if inputString is not empty
    timer = Timer(const Duration(milliseconds: 200), (() {
      print("Requesting: " + inputString);
      setState(() {
        requestString = inputString;
      });
    }));
  }

  void handleSubmit() {
    print(inputString);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            color: const Color(0xFFF4F4F4),
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: handleInput,
                    onSubmitted: ((_) {
                      handleSubmit();
                    }),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Search by word...',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF1E1E1E),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                TextButton(
                    onPressed: handleSubmit,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF7B67FD)),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(17)),
                    ),
                    child: Image(
                      image: AssetImage("assets/images/search.png"),
                      width: 25,
                      height: 25,
                    )),
                // Text(this.)
              ],
            ),
          ),
          Text("Requesting Data: " + requestString)
        ],
      ),
    );
  }
}
