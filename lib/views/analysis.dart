import 'dart:io';
import "dart:convert";

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:BirthmarkRecognition/controllers/imageHandler.dart' as ih;

/// Stateful-Widget as startPage.
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

/// State of MyHomePage. UI to choose picture from camera as well as gallery.
/// After selections users can upload an image to the backend and will receive
/// a jsonResult which is then shown in a Cupertino-Dialog.
class MyHomePageState extends State<MyHomePage> {
  /// File which represents the current selected image. Image to classify.
  File file;
  /// How precise should be confidence rates presented? The higher the more
  /// numbers after comma.
  int precision = 6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analysis"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CupertinoButton(
                  child: Text("Make picture"),
                  onPressed: () async {
                    var f = await ih.chooseCamera();
                    setState(() {
                      file = f;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                CupertinoButton(
                  onPressed: () async {
                    var f = await ih.chooseGallery();
                    setState(() {
                      file = f;
                    });
                  },
                  child: Text("Choose from gallery"),
                ),
                SizedBox(width: 10.0),
                CupertinoButton(
                  onPressed: () async {
                    var result = await jsonDecode(await ih.analyze(file));

                    showDialog(
                      context: context,
                      builder: (BuildContext ctx) => CupertinoAlertDialog(
                            title: const Text("Results"),
                            content: Column(
                              children: <Widget>[
                                Row(children: <Widget>[
                                  Text(result[0]["name"] +
                                      ": " +
                                  this.formatPrecision(result[0]["confidence"]))
                                ]),
                                Row(children: <Widget>[
                                  Text(result[1]["name"] +
                                      ": " +
                                      this.formatPrecision(result[1]["confidence"]))
                                ]),
                                Row(children: <Widget>[
                                  Text(result[2]["name"] +
                                      ": " +
                                      this.formatPrecision(result[2]["confidence"]))
                                ]),
                              ],
                            ),
                          ),
                    );
                  },
                  child: Text("Analyze now"),
                ),
              ],
            ),
            file == null ? Text("No image selected") : Image.file(file)
          ],
        ),
      ),
    );
  }

  /// Formats confidence rates to make them more appealing.
  /// @param rawValue: Unformatted confidence rate as string.
  /// @return String: Return formatted string.
  String formatPrecision(String rawValue) {
    return (double.parse(rawValue)*100).toStringAsFixed(precision)+" %";
  }
}
