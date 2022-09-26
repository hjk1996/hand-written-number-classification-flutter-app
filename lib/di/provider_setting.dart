import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:temp/presentation/home/home_view_model.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

Future<List<SingleChildWidget>> getProvider() async {
  final interpreter = await tfl.Interpreter.fromAsset('model.tflite');
  return [
    ChangeNotifierProvider(
      create: (context) => HomeViewModel(interpreter),
    )
  ];
}
