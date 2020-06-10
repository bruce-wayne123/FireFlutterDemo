import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:networking_demo/widgets/newsList.dart';
import 'package:load/load.dart';
void main() => runApp(
  LoadingProvider(
    themeData: LoadingThemeData(
      // tapDismiss: false,
    ),
    child: App(),
  ),
);


class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Networking",
      home: NewsList()
    );
  }

}
