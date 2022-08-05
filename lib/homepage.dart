import 'package:flutter/material.dart';
import 'package:wordlys/bloc/api_handler.dart';
import 'package:wordlys/components/result_view/result_view.dart';
import 'package:wordlys/components/top_appbar.dart';
import 'package:wordlys/components/word_input.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final apiHandler = APIHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const TopAppBar(),
          WordInput(
            apiHandler: apiHandler,
          ),
          ResultView(
            apiHandler: apiHandler,
          ),
        ],
      )),
    );
  }
}
