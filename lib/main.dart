import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordlys/bloc/api_handler.dart';
import 'package:wordlys/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => APIHandler())],
      child: MaterialApp(
        title: 'Wordlys',
        theme: ThemeData(
          fontFamily: "Poppins",
        ),
        home: HomePage(),
      ),
    );
  }
}
