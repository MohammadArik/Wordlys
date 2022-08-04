import 'package:flutter/widgets.dart';
import 'package:wordlys/bloc/api_handler.dart';

class ResultView extends StatelessWidget {
  const ResultView({required this.apiHandler});
  final APIHandler apiHandler;

  @override
  Widget build(BuildContext context) {
    return Text("Test");
  }
}
