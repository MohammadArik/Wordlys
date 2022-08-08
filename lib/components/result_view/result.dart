import 'package:flutter/material.dart';
import 'package:wordlys/components/result_view/result_view.dart';
import 'package:wordlys/const/colors.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: Size.infinite.width,
        color: const Color(PRIMARY),
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: ResultView(),
      ),
    );
  }
}
