import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wordlys/const/colors.dart';

final Uri supportUri = Uri.parse('https://www.buymeacoffee.com/wordlys');

class TopAppBar extends StatelessWidget {
  const TopAppBar({Key? key}) : super(key: key);

  Future<void> handleSupportUsClick() async {
    await launchUrl(
      supportUri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Image(
                  image: AssetImage("assets/images/logo.png"),
                  width: 48,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Wordlys",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                // const Expanded(
                //   child: SizedBox(),
                // ),
                // TextButton(
                //     onPressed: handleSupportUsClick,
                //     style: ButtonStyle(
                //         backgroundColor: MaterialStateProperty.all<Color>(
                //             const Color(HIGHLIGHT)),
                //         foregroundColor: MaterialStateProperty.all<Color>(
                //             const Color(HIGHLIGHT_TEXT)),
                //         padding: MaterialStateProperty.all<EdgeInsets>(
                //             const EdgeInsets.symmetric(
                //                 vertical: 8, horizontal: 12))),
                //     child: Row(
                //       children: const [
                //         Image(
                //             image: AssetImage("assets/images/support.png"),
                //             width: 20),
                //         SizedBox(
                //           width: 6,
                //         ),
                //         Text("Support Us",
                //             style: TextStyle(
                //               fontSize: 16,
                //             )),
                //       ],
                //     ))
              ],
            )),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(HIGHLIGHT),
            width: Size.infinite.width,
            child: const Text(
              "Simple word definition, synonyms\n& antonyms finder!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(HIGHLIGHT_TEXT),
                fontSize: 16,
              ),
            ))
      ],
    );
  }
}
