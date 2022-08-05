import 'package:flutter/material.dart';
import 'package:wordlys/const/colors.dart';

class DefinitionObject extends StatelessWidget {
  const DefinitionObject({required this.definition});
  final String definition;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Size.infinite.width,
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFFF9F8FF),
        border: Border.all(
          color: Color(BORDER),
        ),
      ),
      padding: EdgeInsets.all(12),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Color(PRIMARY_TEXT),
            fontSize: 16,
          ), //apply style to all
          children: [
            TextSpan(
              text: "Definition: ",
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            TextSpan(
              text: definition,
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
