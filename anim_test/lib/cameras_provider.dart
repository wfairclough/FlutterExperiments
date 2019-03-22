import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CamerasProvider extends StatefulWidget {
  // Your apps state is managed by the container
  final List<CameraDescription> cameras;
  // This widget is simply the root of the tree,
  // so it has to have a child!
  final Widget child;

  CamerasProvider({
    @required this.child,
    this.cameras,
  });

  // This creates a method on the AppState that's just like 'of'
  // On MediaQueries, Theme, etc
  // This is the secret to accessing your AppState all over your app
  static _CamerasProviderState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  _CamerasProviderState createState() => new _CamerasProviderState();
}

class _CamerasProviderState extends State<CamerasProvider> {
  // Just padding the state through so we don't have to
  // manipulate it with widget.state.
  List<CameraDescription> cameras;

  @override
  void initState() {
    availableCameras().then((cams) {
      print(cams.map((cam) => cam.toString()).join(','));
      var back = cams
          .firstWhere((cam) => cam.lensDirection == CameraLensDirection.back);
      var front = cams
          .firstWhere((cam) => cam.lensDirection == CameraLensDirection.front);
      setState(() {
        cameras = List.of([back, front]);
      });
    }).catchError((err) {
      print(err.description);
    });
    super.initState();
  }

  // So the WidgetTree is actually
  // CamerasProvider --> InheritedStateContainer --> The rest of your app.
  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

// This is likely all your InheritedWidget will ever need.
class _InheritedStateContainer extends InheritedWidget {
  // The data is whatever this widget is passing down.
  final _CamerasProviderState data;

  // InheritedWidgets are always just wrappers.
  // So there has to be a child,
  // Although Flutter just knows to build the Widget thats passed to it
  // So you don't have have a build method or anything.
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // This is a better way to do this, which you'll see later.
  // But basically, Flutter automatically calls this method when any data
  // in this widget is changed.
  // You can use this method to make sure that flutter actually should
  // repaint the tree, or do nothing.
  // It helps with performance.
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
