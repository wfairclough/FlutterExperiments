import 'package:annotate_photos/sketch_pad.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  SketchPad _sketchPad;
  final _sign = GlobalKey<SketchPadState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    _sketchPad = SketchPad(
      key: _sign,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _sketchPad,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _sign.currentState.clear();
        },
        tooltip: 'Increment',
        child: Icon(Icons.clear),
      ),
    );
  }
}
