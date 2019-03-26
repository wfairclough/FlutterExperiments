import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class SketchPad extends StatefulWidget {
  final Color color;
  final double strokeWidth;
  final CustomPainter backgroundPainter;
  final Function onSign;

  SketchPad({
    this.color = Colors.black,
    this.strokeWidth = 5.0,
    this.backgroundPainter,
    this.onSign,
    Key key,
  }) : super(key: key);

  SketchPadState createState() => SketchPadState();

  static SketchPadState of(BuildContext context) {
    return context.ancestorStateOfType(TypeMatcher<SketchPadState>());
  }
}

class _SketchPadPainter extends CustomPainter {
  Size _lastSize;
  double strokeWidth;
  final List<OffsetWithVelocity> points;
  final Color strokeColor;
  Paint _linePaint;

  _SketchPadPainter(
      {@required this.points,
      @required this.strokeColor,
      @required this.strokeWidth}) {
    _linePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _lastSize = size;
    for (int i = 0; i < points.length - 1; i++) {
      OffsetWithVelocity point = points[i];
      if (point != null && points[i + 1] != null) {
        double velocity = point.velocity;
        print('inverse velocity: ${1 / velocity}    velocity:  $velocity');
        strokeWidth = 1 / (velocity * 15);
        strokeWidth = strokeWidth > 6.0 ? 6.0 : strokeWidth;
        strokeWidth = strokeWidth < 0.5 ? 0.5 : strokeWidth;
        _linePaint..strokeWidth = strokeWidth;
        canvas.drawLine(point, points[i + 1], _linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(_SketchPadPainter other) => other.points != points;
}

class OffsetWithVelocity extends Offset {
  double velocity = 0.0;
  OffsetWithVelocity(double dx, double dy, this.velocity) : super(dx, dy);
}

class SketchPadState extends State<SketchPad> {
  List<OffsetWithVelocity> _points = <OffsetWithVelocity>[];
  _SketchPadPainter _painter;
  double _strokeWidth = 5.0;
  Size _lastSize;

  Duration _prevTimeStamp;

  SketchPadState();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
    _painter = _SketchPadPainter(
      points: _points,
      strokeColor: widget.color,
      strokeWidth: _strokeWidth,
    );
    return ClipRect(
      child: CustomPaint(
        painter: widget.backgroundPainter,
        foregroundPainter: _painter,
        child: GestureDetector(
          onPanUpdate: (DragUpdateDetails details) {
            double velocity = 0.0;
            if (_prevTimeStamp != null) {
              var timeDelta = details.sourceTimeStamp.inMilliseconds -
                  _prevTimeStamp.inMilliseconds;
              velocity = details.delta.distance / timeDelta;
            }
            _prevTimeStamp = details.sourceTimeStamp;
            RenderBox referenceBox = context.findRenderObject();
            Offset localPosition =
                referenceBox.globalToLocal(details.globalPosition);
            OffsetWithVelocity offset = OffsetWithVelocity(
              localPosition.dx,
              localPosition.dy,
              velocity,
            );
            setState(() {
              _points = List.from(_points)..add(offset);
              if (widget.onSign != null) {
                widget.onSign();
              }
            });
          },
          onPanEnd: (DragEndDetails details) => _points.add(null),
        ),
      ),
    );
  }

  Future<ui.Image> getData() {
    var recorder = ui.PictureRecorder();
    var origin = Offset(0.0, 0.0);
    var paintBounds = Rect.fromPoints(
        _lastSize.topLeft(origin), _lastSize.bottomRight(origin));
    var canvas = Canvas(recorder, paintBounds);
    widget.backgroundPainter.paint(canvas, _lastSize);
    _painter.paint(canvas, _lastSize);
    var picture = recorder.endRecording();
    return picture.toImage(_lastSize.width.round(), _lastSize.height.round());
  }

  void clear() {
    setState(() {
      _points = [];
    });
  }

  bool get hasPoints => _points.length > 0;

  List<Offset> get points => _points;

  afterFirstLayout(BuildContext context) {
    _lastSize = context.size;
  }
}
