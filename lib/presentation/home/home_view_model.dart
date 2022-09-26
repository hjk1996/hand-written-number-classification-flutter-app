import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:temp/domain/constant.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel(this.interpreter);
  final Interpreter interpreter;

  List<List<Offset>> _pointList = [];
  List<List<Offset>> get pointList => _pointList;
  List? _imageArray;
  int? predictedNumber;
  List<dynamic>? probabilites;

  final Paint _paintSetting = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5
    ..strokeCap = StrokeCap.round
    ..color = Colors.white;

  void onPanStart(Offset point) {
    _pointList.add([point]);
    notifyListeners();
  }

  void onPanUpdate(Offset point) {
    if (point.dx >= 0 &&
        point.dx <= canvasSize.width &&
        point.dy >= 0 &&
        point.dy <= canvasSize.height) {
      _pointList.last.add(point);
      notifyListeners();
    }
  }

  Future<void> onPanEnd() async {
    final picture = _makePictureFromPointList();
    if (picture != null) {
      _imageArray = await _makeFloat32ListFromPicture(picture);
      _predict();
    }
    notifyListeners();
  }

  void _predict() {
    var output = List.filled(10, 0).reshape([1, 10]);
    interpreter.run(_imageArray!, output);
    output = output.reshape([10]);
    probabilites = output;
    predictedNumber =
        output.indexOf(output.reduce((cur, next) => cur > next ? cur : next));
  }

  Future<List> _makeFloat32ListFromPicture(ui.Picture picture) async {
    final img = await picture.toImage(28, 28);
    final imgBytes = await img.toByteData();
    final resultBytes = Float32List(28 * 28);
    final buffer = Float32List.view(resultBytes.buffer);
    int index = 0;

    // 픽셀당 rgb 채널이 순차적으로  imgBytes에 들어있음.
    for (int i = 0; i < imgBytes!.lengthInBytes; i += 4) {
      final r = imgBytes.getUint8(i);
      final g = imgBytes.getUint8(i + 1);
      final b = imgBytes.getUint8(i + 2);
      buffer[index++] = (r + g + b) / 3.0 / 255;
    }
    return buffer.reshape([1, 28, 28, 1]);
  }

  ui.Picture? _makePictureFromPointList() {
    if (_pointList.isNotEmpty) {
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(
          recorder, Rect.fromLTWH(0, 0, canvasSize.width, canvasSize.height))
        ..scale(28 / canvasSize.width);

      for (int i = 0; i < _pointList.length; i++) {
        canvas.drawPoints(ui.PointMode.polygon, _pointList[i], _paintSetting);
      }
      return recorder.endRecording();
    }

    return null;
  }

  void clearCanvans() {
    _pointList = [];
    _imageArray = null;
    predictedNumber = null;
    probabilites = null;
    notifyListeners();
  }
}
