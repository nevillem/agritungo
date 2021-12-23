import 'package:agritungo/myfarm/livestock_farm/modals/icome_modal.dart';
import 'package:agritungo/network_helper/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
//const Color blueColor = Color(0xff1565C0);
const Color blueColor = Color(0xFFF9C404);
//const Color orangeColor = Color(0xffFFA000);
const Color orangeColor = Color(0xFF73B41A);

class LiveStockStatistics extends StatefulWidget {
  const LiveStockStatistics({Key? key}) : super(key: key);
   @override
  _LiveStockStatisticsState createState() => _LiveStockStatisticsState();
}


class _LiveStockStatisticsState extends State<LiveStockStatistics> {
  List<IncomeModel> incomes = [];
  bool loading = true;
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  NetworkHelper _networkHelper = NetworkHelper();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var response = await _networkHelper.get(
        "https://api.genderize.io/?name[]=balram&name[]=deepa&name[]=saket&name[]=bhanu&name[]=aquib");
    List<IncomeModel> tempdata = incomeModelFromJson(response.body);
    setState(() {
      incomes = tempdata;
      loading = false;
    });
  }

  List<charts.Series<IncomeModel, String>> _createSampleData() {
    return [
      charts.Series<IncomeModel, String>(
        data: incomes,
        id: 'income',
       // colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        domainFn: (IncomeModel incomeModel, _) => incomeModel.month,
        measureFn: (IncomeModel incomeModel, _) => incomeModel.count,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(orangeColor),
        labelAccessorFn: (IncomeModel incomeModel, _)=>
        'income: ${incomeModel.count.toString()}',
        displayName: "Income",
      )..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      _createSampleData(),
      animate: true,
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
}
