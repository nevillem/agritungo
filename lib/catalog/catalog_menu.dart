import 'dart:convert';

import 'package:agritungo/catalog/animal_breeds/breeds_main.dart';
import 'package:agritungo/catalog/colors/colors_main.dart';
import 'package:agritungo/catalog/farmer_user_type/user_type.dart';
import 'package:agritungo/catalog/feed_items/feed_item_main.dart';
import 'package:agritungo/catalog/item_units/item_units.dart';
import 'package:agritungo/catalog/manage_stall/manage_stall_main.dart';
import 'package:agritungo/catalog/monitoring_services/catalog_monitoring.dart';
import 'package:agritungo/catalog/vaccination/vaccination_main.dart';
import 'package:agritungo/myfarm/my_farm.dart';
import 'package:agritungo/signup/register.dart';
import 'package:agritungo/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Catalog extends StatefulWidget {
  const Catalog({Key? key}) : super(key: key);

  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPrefs();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text('Catalog'),
          titleTextStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 20,),
          elevation: 5,
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() {
              //Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyFarm()));
            },
          )
      ),
      body: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            _CatalogListItems(context, screenHeight, screenwidth),
          ]
      ),
    );
  }
  Widget _CatalogListItems (BuildContext context, double screenHeight, screenwidth) {
    return SliverToBoxAdapter(
        child: Container(
          width: screenwidth * .44,
          margin: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 5.0,
          ),

          child:Wrap(
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            children:<Widget> [

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

                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ManageStallMain()));
                        },
                        child: Container(
                          margin:EdgeInsets.only(left:2),
                          //height: screenHeight * 0.20,
                          child: Text('Manage Stall',
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15.0,
                              //fontWeight:FontWeight.w800,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ),
                      Icon(FontAwesomeIcons.angleRight,
                        size: 20,
                        color: Color(0xFFFFFFFF),)
                    ]),
              ),

              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ColorsMain()));
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

                        Container(
                          margin:EdgeInsets.only(left:2),
                          //height: screenHeight * 0.20,
                          child: Text('Colors',
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15.0,
                              //fontWeight:FontWeight.w800,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Icon(FontAwesomeIcons.angleRight,
                          size: 20,
                          color: Color(0xFFFFFFFF),
                        )
                      ]),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CatalogMonitoring()));
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

                        Container(
                          margin:EdgeInsets.only(left:2),
                          //height: screenHeight * 0.20,
                          child: Text('Monitoring',
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15.0,
                              //fontWeight:FontWeight.w800,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Icon(FontAwesomeIcons.angleRight,
                          size: 20,
                          color: Color(0xFFFFFFFF),
                        )
                      ]),
                ),
              ),

              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BreedsMain()));
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

                        Container(
                          margin:EdgeInsets.only(left:2),
                          //height: screenHeight * 0.20,
                          child: Text('Animal Breed',
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15.0,
                              //fontWeight:FontWeight.w800,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Icon(FontAwesomeIcons.angleRight,
                          size: 20,
                          color: Color(0xFFFFFFFF),
                        )
                      ]),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => VaccinationMain()));
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

                        Container(
                          margin:EdgeInsets.only(left:2),
                          //height: screenHeight * 0.20,
                          child: Text('Vaccines',
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15.0,
                              //fontWeight:FontWeight.w800,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Icon(FontAwesomeIcons.angleRight,
                          size: 20,
                          color: Color(0xFFFFFFFF),
                        )
                      ]),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedItems()));
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
                        Container(
                          margin:EdgeInsets.only(left:2),
                          //height: screenHeight * 0.20,
                          child: Text('Feed Items',
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15.0,
                              //fontWeight:FontWeight.w800,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Icon(FontAwesomeIcons.angleRight,
                          size: 20,
                          color: Color(0xFFFFFFFF),
                        )
                      ]),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ItemUnits()));
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
                        Container(
                          margin:EdgeInsets.only(left:2),
                          //height: screenHeight * 0.20,
                          child: Text('Unit Items',
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15.0,
                              //fontWeight:FontWeight.w800,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Icon(FontAwesomeIcons.angleRight,
                          size: 20,
                          color: Color(0xFFFFFFFF),
                        )
                      ]),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserType()));
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
                        Container(
                          margin:EdgeInsets.only(left:2),
                          //height: screenHeight * 0.20,
                          child: Text('User Types',
                            style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 15.0,
                              //fontWeight:FontWeight.w800,
                              fontWeight: FontWeight.normal,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Icon(FontAwesomeIcons.angleRight,
                          size: 20,
                          color: Color(0xFFFFFFFF),
                        )
                      ]),
                ),
              ),


            ],
          ),

        )


    );
  }
  var accessToken;
  var refreshToken;
  var sessionid;
  _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(this.mounted){
      setState(() {
        accessToken= prefs.getString('access_token');
        refreshToken= prefs.getString('refresh_token');
        sessionid= prefs.getInt('session_id');
      });
    }
    String url = ('https://api.v1.agritungo.com/API/users');
    print(sessionid);
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-type": "application/json",
      'Authorization': '$accessToken',
    };
    print('refreshtoken: $refreshToken');
    Response responsee = await get(
        Uri.parse(url), headers: headers);
    if (responsee.statusCode == 401) {
      Map _refreshLogin = {
        'refresh_token': refreshToken,
      };
      var _json = utf8.encode(jsonEncode(_refreshLogin));
      String urlRefresh = ('https://api.v1.agritungo.com/API/sessions/$sessionid');
      Response responseRefresh = await patch(
          Uri.parse(urlRefresh), headers: headers, body: _json);
      Map data = jsonDecode(responseRefresh.body);
      if (responseRefresh.statusCode == 200) {
        print(data);
        print('new refresh' + data['data']['refresh_token']);
        prefs.setString('access_token', data['data']['access_token']);
        prefs.setString('refresh_token', data['data']['refresh_token']);
        prefs.reload();
      }
      else if (responseRefresh.statusCode == 401) {
        prefs.clear();
        print('refreshtokenerror' + responseRefresh.body);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Register()),
                (Route<dynamic> route) => false);
      }
      else{
        print('others');
        print(responseRefresh.statusCode);
      }
    }
    else {
      print(responsee.body);
      // print(responsee.statusCode);
    }
  }
}
