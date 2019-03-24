import 'package:flutter/material.dart';
import 'package:loader_test/loader_cover.dart';
import 'package:font_awesome_flutter_pro/font_awesome_flutter_pro.dart';

class LoaderApp extends StatelessWidget {
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
      home: LoaderHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class LoaderHomePage extends StatefulWidget {
  LoaderHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoaderHomePageState createState() => _LoaderHomePageState();
}

class _LoaderHomePageState extends State<LoaderHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (item) {
              print('item: $item');
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 1,
                  child: Row(children: [
                    Icon(Icons.signal_cellular_no_sim),
                    SizedBox(width: 16.0),
                    Text("Cell"),
                  ]),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Row(children: [
                    Icon(Icons.settings),
                    SizedBox(width: 16.0),
                    Text("Settings"),
                  ]),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Row(children: [
                    Icon(Icons.sync_disabled),
                    SizedBox(width: 16.0),
                    Text("Sync"),
                  ]),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showLoaderDialog(context: context, loadingText: 'Loading');
        },
        tooltip: 'Increment',
        child: Container(
          padding: const EdgeInsets.only(right: 1),
          child: MirrorTransform(
            child: Icon(FontAwesomeIcons.redo),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MirrorTransform extends StatelessWidget {
  final Offset _offset = const Offset(-3, 0);
  final Widget child;

  const MirrorTransform({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      // Transform widget
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(_offset.dy)
        ..rotateY(_offset.dx),
      alignment: FractionalOffset.center,
      child: child,
    );
  }
}
