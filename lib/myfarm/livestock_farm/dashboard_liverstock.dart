import 'package:agritungo/myfarm/livestock_farm/livestockstatisticks/livestock_chart.dart';
import 'package:agritungo/myfarm/livestock_farm/milk_palour/milk_palour_main.dart';
import 'package:agritungo/myfarm/manage_animal/manage_animal.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/rendering.dart';

class DasboardLiveStock extends StatefulWidget {
  const DasboardLiveStock({Key? key}) : super(key: key);

  @override
  _DasboardLiveStockState createState() => _DasboardLiveStockState();
}

class _DasboardLiveStockState extends State<DasboardLiveStock> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers:<Widget>[
          _walletBalance(screenHeight),
          _shortReport(screenHeight, screenwidth),
          _barChart(screenHeight, screenwidth),
          _livestocOption(screenHeight, screenwidth)


        ]
    );
  }
  SliverToBoxAdapter _walletBalance(screenHeight){
    return SliverToBoxAdapter(
      child: Container(
        height: 90,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10,),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text('Ugx. 1,000',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: Color(0xFF737373),
                      )
                  ),
                  Text(
                    'Total Monthly Expenditure',
                    style: TextStyle(fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Color(0xFF737373),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              color: Colors.grey.withOpacity(0.4),
              width: 1,
            ), // THE DIVIDER. CHANGE THIS TO ACCOMMODATE YOUR NEEDS
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Text('Ugx. 5000',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Color(0xFF737373)
                      ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: Colors.grey.withOpacity(0.4),
                    width: 1,
                  ),
                  Text('Total Monthly Icome',
                    style: TextStyle(fontWeight: FontWeight.normal,
                    fontSize: 13,
                    color: Color(0xFF737373)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  SliverToBoxAdapter _shortReport(double screenHeight, screenwidth) {
    return SliverToBoxAdapter(
        child:Container(
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
    ),
    margin: const EdgeInsets.symmetric(
    vertical: 4.0,
    horizontal: 10.0,
    ),
    height: 60,
    child: Row(
    children: [
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF73B41A),

                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: Text('Total Animals',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: Colors.white
                ),
              ),
            ),
            Text(
              '0',
              style: TextStyle(fontWeight: FontWeight.normal,
                fontSize: 13,
                color: Color(0xFF737373),
              ),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: Colors.grey.withOpacity(0.4),
        width: 1,
      ), // THE DIVIDER. CHANGE THIS TO ACCOMMODATE YOUR NEEDS
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF73B41A),
                
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
              child: Text('Total Male',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: Colors.white
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 2),
              color: Colors.grey.withOpacity(0.4),
              width: 1,
            ),
            Text('0',
              style: TextStyle(fontWeight: FontWeight.normal,
                  fontSize: 13,
                  color: Color(0xFF737373)),
            ),
          ],
        ),
      )
      ]
    )
  )
  );
  }
  SliverToBoxAdapter _barChart (double screenHeight, screenwidth){
    return SliverToBoxAdapter(
     child:Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 10.0,
        ),
       child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              height: 300,
             // child: LegendOptions.withSampleData(),
              child: LiveStockStatistics(),
            ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 10.0,
                ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF9C404),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.only(
                      top: 4.0,
                      left: 5.0,
                    ),
                    padding: EdgeInsets.fromLTRB(13, 5, 13, 5),
                    child: Text('Today',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white
                      ),),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(13, 5, 13, 5),
                      decoration: BoxDecoration(
                      color: Color(0xFFF9C404),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.only(
                      top: 4.0,
                      left: 5.0,
                    ),
                    child: Text('Weekly',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white
                      ),),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(13, 5, 13, 5),
                      decoration: BoxDecoration(
                      color: Color(0xFFF9C404),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.only(
                      top: 4.0,
                      left: 5.0,
                    ),
                    child: Text('Monthly',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white
                      ),
                    ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(13, 5, 13, 5),
                      decoration: BoxDecoration(
                      color: Color(0xFFF9C404),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.only(
                      top: 4.0,
                      left: 5.0,
                    ),
                    child: Text('Yearly',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white
                    ),),
                    )
                    ],
              ),
            ),
            SizedBox(height: 10,),

          ],
        ),
      ),

    );
  }
  SliverToBoxAdapter _livestocOption (double screenHeight, screenwidth){
    return SliverToBoxAdapter(
      child:Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
         // color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(5.0),
        ),
        //height: screenHeight * 0.20,
        // color: Colors.white,

        child: Wrap(
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          children:<Widget> [
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MilkPalour()));
              },
              child: Container(
                width: screenwidth * .44,
                margin: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 5.0,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF737373),
                  borderRadius: BorderRadius.circular(5.0),
                ),

                height: 40,

                child:Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.burn,
                        size: 15,
                        color: Color(0xFFFFFFFF),),
                      Container(
                        margin:EdgeInsets.only(left:2),
                        //height: screenHeight * 0.20,
                        child: Text('Milk Parlour',
                          style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 12.0,
                            //fontWeight:FontWeight.w800,
                            fontWeight: FontWeight.normal,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Icon(FontAwesomeIcons.angleRight,
                        size: 10,
                        color: Color(0xFFFFFFFF),)
                    ]),
              ),
            ),
            Container(
              width: screenwidth * .44,
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 5.0,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF737373),
                borderRadius: BorderRadius.circular(5.0),
              ),

              height: 40,

              child:Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.pagelines,
                      size: 15,
                      color: Color(0xFFFFFFFF),),
                    Container(
                      margin:EdgeInsets.only(left:2),
                      //height: screenHeight * 0.20,
                      child: Text('Feeds',
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 12.0,
                          //fontWeight:FontWeight.w800,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Icon(FontAwesomeIcons.angleRight,
                      size: 10,
                      color: Color(0xFFFFFFFF),
                    )
                  ]),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ManageAnimalMain()));
              },
              child: Container(
                width: screenwidth * .44,
                margin: const EdgeInsets.symmetric(
                  vertical: 4.0,
                  horizontal: 5.0,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF737373),
                  borderRadius: BorderRadius.circular(5.0),
                ),

                height: 40,

                child:Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.tv,
                        size: 15,
                        color: Color(0xFFFFFFFF),),
                      Container(
                        margin:EdgeInsets.only(left:2),
                        //height: screenHeight * 0.20,
                        child: Text('Animal monitor',
                          style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 12,
                            //fontWeight:FontWeight.w800,
                            fontWeight: FontWeight.normal,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Icon(FontAwesomeIcons.angleRight,
                        size: 10,
                        color: Color(0xFFFFFFFF),
                      )
                    ]),
              ),
            ),
            Container(
              width: screenwidth * .44,
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 5.0,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF737373),
                borderRadius: BorderRadius.circular(5.0),
              ),

              height: 40,

              child:Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.moneyBillAlt,
                      size: 15,
                      color: Color(0xFFFFFFFF),),
                    Container(
                      margin:EdgeInsets.only(left:2),
                      //height: screenHeight * 0.20,
                      child: Text('Animal Sale',
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 12.0,
                          //fontWeight:FontWeight.w800,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Icon(FontAwesomeIcons.angleRight,
                      size: 10,
                      color: Color(0xFFFFFFFF),
                    )
                  ]),
            ),
            Container(
              width: screenwidth * .44,
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 5.0,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF737373),
                borderRadius: BorderRadius.circular(5.0),
              ),

              height: 40,

              child:Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.democrat,
                      size: 15,
                      color: Color(0xFFFFFFFF),),
                    Container(
                      margin:EdgeInsets.only(left:2),
                      //height: screenHeight * 0.20,
                      child: Text('Manage Animal',
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 12.0,
                          //fontWeight:FontWeight.w800,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Icon(FontAwesomeIcons.angleRight,
                      size: 10,
                      color: Color(0xFFFFFFFF),
                    )
                  ]),
            ),
            Container(
              width: screenwidth * .44,
              margin: const EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 5.0,
              ),
              decoration: BoxDecoration(
                color: Color(0xFF737373),
                borderRadius: BorderRadius.circular(5.0),
              ),

              height: 40,
              child:Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.home,
                      size: 15,
                      color: Color(0xFFFFFFFF),),
                    Container(
                      margin:EdgeInsets.only(left:2),
                      //height: screenHeight * 0.20,
                      child: Text('Manage Stall',
                        style: const TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 12.0,
                          //fontWeight:FontWeight.w800,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    Icon(FontAwesomeIcons.angleRight,
                      size: 10,
                      color: Color(0xFFFFFFFF),
                    )
                  ]),
            ),
            // Container(
            //   width: screenwidth * .95,
            //   margin: const EdgeInsets.symmetric(
            //     vertical: 4.0,
            //     horizontal: 5.0,
            //   ),
            //   decoration: BoxDecoration(
            //     color: Color(0xFF73B41A),
            //     borderRadius: BorderRadius.circular(5.0),
            //   ),
            //
            //   height: 40,
            //   child:Row(
            //       mainAxisSize: MainAxisSize.min,
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Container(
            //           margin:EdgeInsets.only(left:2),
            //           //height: screenHeight * 0.20,
            //           child: Text('Milk Parlour',
            //             style: const TextStyle(
            //               color: Color(0xFFFFFFFF),
            //               fontSize: 15.0,
            //               //fontWeight:FontWeight.w800,
            //               fontWeight: FontWeight.normal,
            //             ),
            //             maxLines: 2,
            //           ),
            //         ),
            //         Icon(FontAwesomeIcons.angleRight,
            //           size: 20,
            //           color: Color(0xFFFFFFFF),)
            //       ]),
            // ),
          ],
        ),
      ),

    );
  }
}
