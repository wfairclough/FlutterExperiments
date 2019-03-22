import 'dart:math';

import 'package:anim_test/camera_page.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class AnimTestApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: AnimTestHomePage(title: 'Animation Test'),
    );
  }
}

class AnimTestHomePage extends StatefulWidget {
  AnimTestHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _AnimTestHomePageState createState() => _AnimTestHomePageState();
}

class _AnimTestHomePageState extends State<AnimTestHomePage> {
  int _counter = 0;
  Color _color = Colors.blue;
  bool _isDark = true;

  double get numDigits {
    var c = _counter;
    var count = 0;
    while (c > 0) {
      c = c ~/ 10.0;
      count++;
    }
    return count + 0.0;
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;

      var randRed = Random().nextInt(0xFF);
      var randGreen = Random().nextInt(0xFF);
      var randBlue = Random().nextInt(0xFF);

      var value = 0xFF << 8 | randRed;
      value = value << 8 | randGreen;
      value = value << 8 | randBlue;
      this._color = Color(value);
      this._isDark = TinyColor(this._color).isDark();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.camera_enhance),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CameraPage()));
              },
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: this._color,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              width: numDigits * 40,
              child: Text(
                '$_counter',
                style: TextStyle(
                  // color: _isDark ? Colors.white : Colors.black,
                  color: Colors.white,
                  fontSize: 44,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
