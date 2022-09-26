import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:temp/domain/constant.dart';

class MyCustomPaint extends StatelessWidget {
  const MyCustomPaint({
    Key? key,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.pointList,
  }) : super(key: key);
  final Function(Offset point) onPanStart;
  final Function(Offset point) onPanUpdate;
  final Function onPanEnd;
  final List<List<Offset>> pointList;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: canvasColor,
      width: canvasSize.width,
      height: canvasSize.height,
      child: GestureDetector(
        onPanStart: (details) {
          final point = details.localPosition;
          onPanStart(point);
        },
        onPanUpdate: (details) {
          final point = details.localPosition;
          onPanUpdate(point);
        },
        onPanEnd: (_) {
          onPanEnd();
        },
        child: CustomPaint(
          size: canvasSize,
          painter: MyCustomPainter(
            pointList: pointList,
          ),
        ),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  final List<List<Offset>> pointList;
  MyCustomPainter({required this.pointList});

  final Paint _paintSetting = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5
    ..strokeCap = StrokeCap.round
    ..color = Colors.black;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointList.length; i++) {
      final currentList = pointList[i];
      canvas.drawPoints(PointMode.polygon, currentList, _paintSetting);
    }
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) => true;
}
