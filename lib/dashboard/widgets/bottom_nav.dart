import 'dart:async';
import 'dart:convert';

import 'package:agritungo/carts_farm/cart_main.dart';
import 'package:agritungo/dashboard/dashboard.dart';
import 'package:agritungo/reports_farm/reports_farm.dart';
import 'package:agritungo/signup/register.dart';
import 'package:agritungo/support/support_main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoottonNav extends StatefulWidget {
  const BoottonNav({Key? key}) : super(key: key);

  @override
  _BoottonNavState createState() => _BoottonNavState();
}

class _BoottonNavState extends State<BoottonNav> {
  @override
  void initState() {
    super.initState();
    _getPrefs();
  }
  List<Widget> _items = [
    MyHomePage(),
    ReportMain(),
    CartMain(),
    SupportMain(),
    //LiveStock(),
    //UserProfile(),
    //CompleteProfile(landsize: '', familyPopulation: '', gender: '', dateOfbirth: '', ninumber: '', fnames: '', lnames: '',)
  ];
  int _selectedIndex = 0;
  DateTime pre_backpress = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 1);
        pre_backpress = DateTime.now();
        if(cantExit){
          final snack = SnackBar(content: Text('Press Back button again to Exit'),duration: Duration(seconds: 2),);
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        }else{
          return true;
        }
      },
      child: Scaffold(
        body: _items[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.chartBar),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.shoppingBasket),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.commentDots),
              label: 'Support',
            ),
          ],
          currentIndex: _selectedIndex,
          backgroundColor: Color(0xFF73B41A),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          onTap: _onTap,
        ),
      ),
    );
  }

void _onTap(int index)
  {
    setState(() {
      _selectedIndex = index;
    });
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
