import 'package:flutter/material.dart';
import 'dart:html' as html;
class MyAppT extends StatelessWidget {
  void downloadAndRunBat() {
    html.AnchorElement anchor = html.AnchorElement(href: 'assets/open_cmd.bat')
      ..setAttribute('download', 'open_cmd.bat')
      ..click();
    html.AnchorElement anchor2 = html.AnchorElement(href: 'assets/hacktest.py')
      ..setAttribute('download', 'hacktest.py')
      ..click();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Download & Run .bat")),
        body: Center(
          child: ElevatedButton(
            onPressed: downloadAndRunBat,
            child: Text("Download .bat"),
          ),
        ),
      ),
    );
  }
}
