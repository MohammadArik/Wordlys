import 'package:flutter/material.dart';
import 'package:wordlys/components/result_view/result_view.dart';
import 'package:wordlys/components/top_appbar.dart';
import 'package:wordlys/components/word_input.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("I am rerendered :(");
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const TopAppBar(),
          WordInput(),
          ResultView(),
        ],
      )),
    );
  }
}
