import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
              children: <Widget>[
                const Image(
                  image: AssetImage("assets/images/logo.png"),
                  width: 48,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "Wordlys",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                TextButton(
                    onPressed: handleSupportUsClick,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF7B67FD)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFFFFFF)),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12))),
                    child: Row(
                      children: const [
                        Image(
                            image: AssetImage("assets/images/support.png"),
                            width: 20),
                        SizedBox(
                          width: 6,
                        ),
                        Text("Support Us",
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    ))
              ],
            )),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF7B67FD),
            child: const Text(
              "Simple word definition, antonyms & synonyms finder!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 16,
              ),
            ))
      ],
    );
  }
}
