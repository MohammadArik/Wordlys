import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wordlys/bloc/api_handler.dart';
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

            print(data);
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

              // TODO do stuff with the data (not implemented yet)
              return Text("Result Data: " + data.mainWord);
            }

            return SizedBox();
          }),
        ),
      ),
    );
  }
}
