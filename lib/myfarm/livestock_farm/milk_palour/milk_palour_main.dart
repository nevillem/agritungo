
import 'package:agritungo/myfarm/livestock_farm/live_stock.dart';
import 'package:agritungo/myfarm/livestock_farm/milk_palour/CollectMilk.dart';
import 'package:agritungo/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MilkPalour  extends StatelessWidget {
  //const ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text('Milk Parlour'),
          titleTextStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 20,),
          elevation: 0.0,
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LiveStock()));
            },
          )
      ),
      body:CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            _milk_parlour_main(context,screenHeight)

          ]
      ),
      // bottomNavigationBar: BoottonNav(),
    );
  }
  Widget _milk_parlour_main (BuildContext context, double screenHeight) {
  return SliverToBoxAdapter(
  child: Container(
  margin: const EdgeInsets.symmetric(
  horizontal: 10.0,
  vertical:4,
  ),
  //padding: const EdgeInsets.all(10.0),
  decoration: BoxDecoration(
  //  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  ),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
  Row(
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
  Flexible(
  child: ListView(
  shrinkWrap: true,
  scrollDirection: Axis.vertical,
  physics: NeverScrollableScrollPhysics(),
  children: <Widget>[
  GestureDetector(
    onTap:(){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CollectMilk()));
    },
    child: Container(
    margin: const EdgeInsets.symmetric(
    //horizontal: 20.0,
    vertical:4,
    ),
    decoration: BoxDecoration(
      color: Color(0xFF737373),
    borderRadius: BorderRadius.circular(5.0),
    ),
    child: ListTile(
    // leading: Icon(
    // FontAwesomeIcons.chartPie
    // ),
    title: Text(
    'Collect Milk',
      style: TextStyle(color: Colors.white,),
    ),
    trailing:MaterialButton(
    minWidth: 30,
    height: 20,
    onPressed: () {

    },
    textColor: Colors.white,
    child: Icon(
    FontAwesomeIcons.angleRight,
    color: Colors.white,
    size: 15,
    ),
    // padding: EdgeInsets.all(8),
    //shape: CircleBorder(),
    ),
    onTap: () {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => CollectMilk()));
    },
    ),
    ),
  ),
 GestureDetector(
    onTap:(){
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => CollectMilk()));
    },
    child: Container(
    margin: const EdgeInsets.symmetric(
    //horizontal: 20.0,
    vertical:4,
    ),
    decoration: BoxDecoration(
      color: Color(0xFF737373),
    borderRadius: BorderRadius.circular(5.0),
    ),
    child: ListTile(
    // leading: Icon(
    // FontAwesomeIcons.chartPie
    // ),
    title: Text(
    'Sale Milk',
      style: TextStyle(color: Colors.white,),
    ),
    trailing:MaterialButton(
    minWidth: 30,
    height: 20,
    onPressed: () {

    },
    textColor: Colors.white,
    child: Icon(
    FontAwesomeIcons.angleRight,
    color: Colors.white,
    size: 15,
    ),
    // padding: EdgeInsets.all(8),
    //shape: CircleBorder(),
    ),
    onTap: () {
    // Navigator.push(context,
    // MaterialPageRoute(builder: (context) => CollectMilk()));
    },
    ),
    ),
  ),
 GestureDetector(
    onTap:(){
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => CollectMilk()));
    },
    child: Container(
    margin: const EdgeInsets.symmetric(
    //horizontal: 20.0,
    vertical:4,
    ),
    decoration: BoxDecoration(
      color: Color(0xFF737373),
    borderRadius: BorderRadius.circular(5.0),
    ),
    child: ListTile(
    // leading: Icon(
    // FontAwesomeIcons.chartPie
    // ),
    title: Text(
    'Sale Due Collection',
      style: TextStyle(color: Colors.white,),
    ),
    trailing:MaterialButton(
    minWidth: 30,
    height: 20,
    onPressed: () {

    },
    textColor: Colors.white,
    child: Icon(
    FontAwesomeIcons.angleRight,
    color: Colors.white,
    size: 15,
    ),
    // padding: EdgeInsets.all(8),
    //shape: CircleBorder(),
    ),
    onTap: () {
    // Navigator.push(context,
    // MaterialPageRoute(builder: (context) => CollectMilk()));
    },
    ),
    ),
  ),

  ]
  ),
  ),
  ]
  )
  ],

  ),
  ),

  );
  }
}
