import 'package:flutter/material.dart';
import 'package:temp/domain/constant.dart';
import 'package:temp/presentation/home/components/bar_chart.dart';
import 'package:temp/presentation/home/components/painter.dart';
import 'package:temp/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Number Classification App",
        ),
        centerTitle: true,
      ),
      body: Container(
        color: primaryColor,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Consumer<HomeViewModel>(
              builder: (context, vm, child) => MyCustomPaint(
                onPanStart: vm.onPanStart,
                onPanUpdate: vm.onPanUpdate,
                onPanEnd: vm.onPanEnd,
                pointList: vm.pointList,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: viewModel.clearCanvans,
              style: ElevatedButton.styleFrom(
                primary: barChartFillColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              child: const Text(
                'Clear Canvas',
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Consumer<HomeViewModel>(
                  builder: (context, vm, child) => MyBarChart(
                    predictedNumber: vm.predictedNumber,
                    probabilities: vm.probabilites,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
