import 'package:agritungo/dashboard/widgets/custom_app_bar.dart';
import 'package:agritungo/dashboard/widgets/drawer_menu.dart';
import 'package:flutter/material.dart';

class SupportMain extends StatefulWidget {
  const SupportMain({Key? key}) : super(key: key);

  @override
  _SupportMainState createState() => _SupportMainState();
}

class _SupportMainState extends State<SupportMain> {
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
