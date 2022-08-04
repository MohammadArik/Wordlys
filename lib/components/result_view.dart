import 'package:flutter/widgets.dart';
import 'package:wordlys/bloc/api_handler.dart';

class ResultView extends StatelessWidget {
  static late APIHandler apiHandler;
  ResultView({required APIHandler handler}) {
    apiHandler = handler;
  }

  @override
  Widget build(BuildContext context) {
    return Text("Test");
  }
}
