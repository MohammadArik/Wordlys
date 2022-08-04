import 'package:flutter/material.dart';
import 'package:wordlys/bloc/api_handler.dart';
import 'package:wordlys/const/colors.dart';

class WordInput extends StatelessWidget {
  static late APIHandler apiHandler;

  WordInput({required APIHandler handler}) {
    apiHandler = handler;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      color: const Color(PRIMARY),
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextField(
              controller: apiHandler.textFieldController,
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
                color: Color(PRIMARY_TEXT),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8),
          TextButton(
              onPressed: (() {}),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(HIGHLIGHT)),
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(17)),
              ),
              child: Image(
                image: AssetImage("assets/images/search.png"),
                width: 25,
                height: 25,
              )),
        ],
      ),
    );
  }
}
