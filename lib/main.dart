import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temp/di/provider_setting.dart';
import 'package:temp/domain/constant.dart';
import 'package:temp/presentation/home/home_view.dart';
import 'package:temp/presentation/home/home_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final provider = await getProvider();
  runApp(MultiProvider(
    providers: provider,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: const AppBarTheme(
              color: primaryColor,
              elevation: 0,
              titleTextStyle:
                  TextStyle(fontSize: 25, color: barChartFillColor))),
      home: const HomeView(),
    );
  }
}
