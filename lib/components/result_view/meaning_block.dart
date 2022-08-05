import 'package:flutter/material.dart';
import 'package:wordlys/const/colors.dart';

class MeaningBlock extends StatefulWidget {
  const MeaningBlock({Key? key}) : super(key: key);

  @override
  State<MeaningBlock> createState() => _MeaningBlockState();
}

class _MeaningBlockState extends State<MeaningBlock> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFFFFF),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(12, 6, 12, 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  border: Border.all(
                    color: Color(HIGHLIGHT),
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                child: Text(
                  "noun",
                  style: TextStyle(
                    color: Color(HIGHLIGHT),
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(child: SizedBox()), // spacing to push button to the side
              IconButton(
                onPressed: (() {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                }),
                icon: isExpanded
                    ? Image.asset(
                        "assets/images/downArrow.png",
                        width: 18,
                      )
                    : Image.asset(
                        "assets/images/upArrow.png",
                        width: 18,
                      ),
                color: Color(0xFFEEEEEE),
                splashColor: Color(0xFFEEEEEE),
                padding: EdgeInsets.all(4),
              ),
            ],
          )
        ],
      ),
    );
  }
}
