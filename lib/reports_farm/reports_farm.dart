import 'package:agritungo/dashboard/widgets/custom_app_bar.dart';
import 'package:agritungo/dashboard/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

class ReportMain extends StatefulWidget {
  const ReportMain({Key? key}) : super(key: key);

  @override
  _ReportMainState createState() => _ReportMainState();
}

class _ReportMainState extends State<ReportMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Color(0xFFF2F2F2),
    appBar: CustomAppBar(),
    drawer: DrawerMenu(),
    body:  Center(
    child:Text('Coming soon',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
      fontFamily: 'Poppins',),),
    ),
    );
  }
}
