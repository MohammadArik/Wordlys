import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wordlys/const/colors.dart';

class SourcesObject extends StatelessWidget {
  final List<dynamic> sources;
  const SourcesObject({required this.sources});

  Future<void> handleSourceClick(int index) async {
    await launchUrl(
      Uri.parse(sources[index]),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (sources.length <= 0) {
      return const SizedBox();
    }

    var sourcesLinks = <Widget>[];
    // var index = 0;
    for (var i = 0; i < sources.length; i++) {
      sourcesLinks.add(GestureDetector(
        onTap: (() {
          handleSourceClick(i);
        }),
        child: Text(
          sources[i] as String,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color(HIGHLIGHT),
          ),
        ),
      ));
    }

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sources",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          ...sourcesLinks
        ],
      ),
    );
  }
}
