import 'dart:math';

import 'package:charts_common/src/chart/common/behavior/legend/legend.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

//const Color blueColor = Color(0xff1565C0);
const Color blueColor = Color(0xFFF9C404);
//const Color orangeColor = Color(0xffFFA000);
const Color orangeColor = Color(0xFF73B41A);

class LegendOptions extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  final bool animate;

  LegendOptions(this.seriesList, {required this.animate});

  factory LegendOptions.withSampleData() {
    return LegendOptions(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
      defaultRenderer: charts.BarRendererConfig(
          cornerStrategy: const charts.ConstCornerStrategy(50)),

      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          desiredMinTickCount: 6,
          desiredMaxTickCount: 10,
        ),
      ),
      secondaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
              desiredTickCount: 6, desiredMaxTickCount: 10)),
      selectionModels: [
        charts.SelectionModelConfig(
            changedListener: (charts.SelectionModel model) {
              if (model.hasDatumSelection)
                print(model.selectedSeries[0]
                    .measureFn(model.selectedDatum[0].index));
            })
      ],
      behaviors: [
        charts.SeriesLegend(),
      ],
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final incomeList = [
      OrdinalSales('Jan', 29),
      OrdinalSales('Feb', 25),
      OrdinalSales('Mar', 100),
      OrdinalSales('Apri', 75),
      OrdinalSales('May', 70),
      OrdinalSales('Jun', 70),
    ];

    final expensesList = [
      OrdinalSales('Jan', 10),
      OrdinalSales('Feb', 25),
      OrdinalSales('Mar', 8),
      OrdinalSales('Apri', 20),
      OrdinalSales('May', 38),
      OrdinalSales('Jun', 70),
    ];

    return [
      charts.Series<OrdinalSales, String>(
          id: 'income',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: incomeList,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(orangeColor),
          labelAccessorFn: (OrdinalSales sales, _) =>
          'income: ${sales.sales.toString()}',
          displayName: "Income"),
      charts.Series<OrdinalSales, String>(
        id: 'expense',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: expensesList,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(blueColor),
        displayName: "Expenses",
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];
  }
}


class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}