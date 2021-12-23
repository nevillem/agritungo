import 'package:agritungo/catalog/catalog_menu.dart';
import 'package:agritungo/dashboard/widgets/bottom_nav.dart';
import 'package:agritungo/myfarm/branches/branches_main.dart';
import 'package:agritungo/myfarm/livestock_farm/live_stock.dart';
import 'package:agritungo/myfarm/manage_animal/manage_animal.dart';
import 'package:agritungo/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/list_data_farm.dart';

class MyFarm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text('My Farm'),
          titleTextStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 20,),
          elevation: 0.0,
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BoottonNav()));
                },
          )
      ),
      body:CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            _DataGridView(context, screenHeight, screenwidth),
            _MyFarmListView(context,screenHeight)

          ]
      ),
     // bottomNavigationBar: BoottonNav(),

    );
  }

  //display listView
  Widget _DataGridView (BuildContext context, double screenHeight, screenwidth){
    return SliverToBoxAdapter(
      child:Container(
        padding: const EdgeInsets.all(10.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(

                  child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      //padding: const EdgeInsets.all(10.0),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 8.0,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      children: myfarm.map((e) {
                        return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              //color:Color.fromRGBO(225, 227, 229, 100),
                              color:Colors.white,


                            ),

                            child: GestureDetector(
                              onTap: () async{
                                //here get image tap callback
                                //print(e);

                                 if(e.values.first=='Manage \n  Livestock Farm'){
                                  print('My Farm');
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => BranchesMain()));
                                }
                                else if(e.values.first=='Manage \n Crop Farm'){
                                  print('Forum');
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => ManageAnimalMain()));

                                }
                                else{
                                  print('not');
                                }
                              },

                              child: Column(

                                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[

                                    Image.asset(
                                      e.keys.first,
                                      // fit: BoxFit.fill,
                                      //height: screenHeight * 0.12,
                                      height: 100,
                                      width: screenwidth * 0.8 ,
                                    ),
                                    // SizedBox(height: screenHeight * 0.015),
                                    Text(
                                      e.values.first,
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w800,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),

                                  ]

                              ),
                            )
                        );
                      }
                      ).toList()),
                ),
              ],
            ),

          ],
        ),

      ),
    );
  }


  Widget _MyFarmListView (BuildContext context, double screenHeight) {
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
                          Container(
                            margin: const EdgeInsets.symmetric(
                              //horizontal: 20.0,
                              vertical:4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),

                            ),
                            child: ListTile(
                              leading: Icon(
                                  FontAwesomeIcons.chartPie
                              ),
                              title: Text(
                                'Catalog',
                              ),
                              trailing:MaterialButton(
                                minWidth: 30,
                                height: 20,
                                onPressed: () {

                                },
                                color: Color(0xFF73B41A),
                                textColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.arrowRight,
                                  size: 10,
                                ),
                                // padding: EdgeInsets.all(8),
                                shape: CircleBorder(),
                              ),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => Catalog()));
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              //horizontal: 20.0,
                              vertical:4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),

                            ),
                            child: ListTile(
                              leading: Icon(
                                  FontAwesomeIcons.tools
                              ),
                              title: Text(
                                'Farm Equipment',
                              ),
                              trailing:MaterialButton(
                                minWidth: 30,
                                height: 20,
                                onPressed: () {},
                                color: Color(0xFF73B41A),
                                textColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.arrowRight,
                                  size: 10,
                                ),
                                // padding: EdgeInsets.all(4),
                                shape: CircleBorder(),
                              ),
                              onTap: () {
                                print('Another data');
                              },
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.symmetric(
                              //horizontal: 20.0,
                              vertical:4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),

                            ),
                            child: ListTile(
                              leading: Icon(
                                  FontAwesomeIcons.userFriends
                              ),
                              title: Text(
                                'Farm Employees',
                              ),
                              trailing:MaterialButton(
                                minWidth: 30,
                                height: 20,
                                onPressed: () {},
                                color: Color(0xFF73B41A),
                                textColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.arrowRight,
                                  size: 10,
                                ),
                                // padding: EdgeInsets.all(8),
                                shape: CircleBorder(),
                              ),
                              onTap: () {
                                print('Another data');
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              //horizontal: 20.0,
                              vertical:4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),

                            ),
                            child: ListTile(
                              leading: Icon(
                                  FontAwesomeIcons.boxes
                              ),
                              title: Text(
                                'Input Supliers',
                              ),
                              trailing:MaterialButton(
                                minWidth: 30,
                                height: 20,
                                onPressed: () {},
                                color: Color(0xFF73B41A),
                                textColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.arrowRight,
                                  size: 10,
                                ),
                                //padding: EdgeInsets.all(8),
                                shape: CircleBorder(),
                              ),
                              onTap: () {
                                print('Another data');
                              },
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.symmetric(
                              //horizontal: 20.0,
                              vertical:4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),

                            ),
                            child: ListTile(
                              leading: Icon(
                                  FontAwesomeIcons.pills
                              ),
                              title: Text(
                                'Veterinary/Agromist',
                              ),
                              trailing:MaterialButton(
                                minWidth: 30,
                                height: 20,
                                onPressed: () {},
                                color: Color(0xFF73B41A),
                                textColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.arrowRight,
                                  size: 10,
                                ),
                                shape: CircleBorder(),
                              ),
                              onTap: () {
                                print('Another data');
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              //horizontal: 20.0,
                              vertical:4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),

                            ),
                            child: ListTile(
                              leading: Icon(
                                  FontAwesomeIcons.moneyBillAlt
                              ),
                              title: Text(
                                'Farm Expenses',
                              ),
                              trailing:MaterialButton(
                                minWidth: 30,
                                height: 20,
                                onPressed: () {},
                                color: Color(0xFF73B41A),
                                textColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.arrowRight,
                                  size: 10,
                                ),
                                // padding: EdgeInsets.all(8),
                                shape: CircleBorder(),
                              ),
                              onTap: () {
                                print('Another data');
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              //horizontal: 20.0,
                              vertical:4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),

                            ),
                            child: ListTile(
                              leading: Icon(
                                  FontAwesomeIcons.cloudSunRain
                              ),
                              title: Text(
                                'Weather Forecast',
                              ),
                              trailing:MaterialButton(
                                minWidth: 30,
                                height: 20,
                                onPressed: () {},
                                color: Color(0xFF73B41A),
                                textColor: Colors.white,
                                child: Icon(
                                  FontAwesomeIcons.arrowRight,
                                  size: 10,
                                ),
                                //padding: EdgeInsets.all(8),
                                shape: CircleBorder(),
                              ),
                              onTap: () {
                                print('Another data');
                              },
                            ),
                          )

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
