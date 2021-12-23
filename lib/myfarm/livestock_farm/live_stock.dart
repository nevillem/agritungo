
import 'package:agritungo/dashboard/widgets/bottom_nav.dart';
import 'package:agritungo/myfarm/livestock_farm/dashboard_liverstock.dart';
import 'package:agritungo/myfarm/livestock_farm/expenditure_report.dart';
import 'package:agritungo/myfarm/livestock_farm/income_report.dart';
import 'package:agritungo/statistics/livestoc_chart.dart';
import 'package:agritungo/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LiveStock extends StatelessWidget {
  const LiveStock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenwidth = MediaQuery
        .of(context)
        .size
        .width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins',),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Color(0xFFF2F2F2),
          appBar: AppBar(
            backgroundColor: MyColors.primaryColor,
            title: Text('My Farm'),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w800, fontSize: 20,),
            elevation: 5,
            leading: IconButton(icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            bottom: TabBar(
              indicatorColor: Color(0xFF73B41A),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
              Tab(text: "Dashboard"),
              Tab(text: "Income"),
              Tab(text: "Expenditure")

            ],
            ),
          ),
          body: TabBarView(
            children: [
              DasboardLiveStock(),
              IncomeReport(),
              ExpenditureReport(),
            ],

          ),
        ),
      ),
    );
  }
}
