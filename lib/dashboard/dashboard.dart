import 'dart:async';
import 'dart:convert';
import 'package:agritungo/dashboard/helpers/dart.dart';
import 'package:agritungo/dashboard/slider_model/slider_model.dart';
import 'package:agritungo/dashboard/widgets/custom_app_bar.dart';
import 'package:agritungo/dashboard/widgets/drawer_menu.dart';
import 'package:agritungo/dashboard/widgets/profile_form.dart';
import 'package:agritungo/dashboard/widgets/slider_dots.dart';
import 'package:agritungo/dashboard/widgets/slider_item.dart';
import 'package:agritungo/myfarm/my_farm.dart';
import 'package:agritungo/signup/register.dart';
import 'package:agritungo/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:gscarousel/gscarousel.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoder/geocoder.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _getPrefs();
    _checkUserRegistration();

    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    //var cardTextStyle= TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Color.fromARGB(63, 63, 63, 1));
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: CustomAppBar(),
      drawer: DrawerMenu(),
      body: RefreshIndicator(
        onRefresh: _checkUserRegistration,
        child: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            _buildHeader(screenHeight),
            _ImageSlider(screenHeight),
            _gardenMapping(screenHeight, screenWidth),
            _buildYourOwnTest(screenHeight),
          ],
        ),
      ),
    );
  }
  SliverToBoxAdapter _buildHeader(double screenHeight) {
    double multiplier = 0.020;
    double multiplier2 = 0.018;
    String greetingMes = greetingMessage();
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

    return SliverToBoxAdapter(
      child: Stack(
        children: <Widget>[
          // The containers in the background
          Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: MyColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        if(user_lname !=null)
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: greetingMes + '!'+'\n',
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 15,),

                                ),
                                TextSpan(text:capitalize(user_lname.toLowerCase()),
                                    style: TextStyle(fontWeight: FontWeight.normal,
                                      fontSize: 15,)),
                              ],
                          ),
                          ),
                        // Text(greetingMes +'!' +'\n'+ capitalize(user_lname.toLowerCase()),
                        //   style: const TextStyle(
                        //     color: Colors.white,
                        //     fontSize: 15.0,
                        //    // fontWeight: FontWeight.bold,
                        //   ),
                        // ),

                        Expanded(
                          //flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 7.0,
                                    horizontal: 30.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF257920FF),
                                    borderRadius: BorderRadius.circular(20.0),

                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.locationArrow,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                      Text(locationns !=null ? locationns:'',
                                      style:TextStyle(color: Colors.white,),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),



                        ),


                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: screenHeight * 0.01),

                      ],
                    ),

                  ],
                ),

              ),

            ],
          ),
          // The card widget with top padding,
          // incase if you wanted bottom padding to work,
          // set the `alignment` of container to Alignment.bottomCenter
          Container(
            alignment: Alignment.topCenter,
            //padding: const EdgeInsets.all(70),
            padding: EdgeInsets.only(
                top: 70,
                right: 20.0,
                left: 20.0),
            child: Container(
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if(urlfn !=null)
                              Image.network(urlfn.toString(), width:50, height: 50,),
                            Text(temp.toString() + symbolTemp !=null ? temp.toString():'' ,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                    color: Colors.black.withOpacity(0.4))),
                          ],
                        ),
                        Text(
                          textCondition.toString() !=null? textCondition.toString():'',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),

                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey.withOpacity(0.4),
                    width: 1,
                  ), // THE DIVIDER. CHANGE THIS TO ACCOMMODATE YOUR NEEDS
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child:Transform.rotate(
                                angle: 100,
                                child: Icon(FontAwesomeIcons.wallet,
                                    size: 25,
                                    color: Color(0xFF737373)),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 5, top: 5),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: 'UGX:',
                                    style: TextStyle(fontWeight: FontWeight.bold,)),
                                    TextSpan(text: ' 0.00'),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          decoration: BoxDecoration(color: Color(0xFFF9C404),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text("Wallet balance",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 12)
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),


    );
  }

  //Products
  SliverToBoxAdapter _gardenMapping(double screenHeight, screenWidth) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20.0,
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
            /*  Text(
              'Prevention Tips',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),*/
            // const SizedBox(height: 20.0),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(

                  child: GestureDetector(
                    child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        //padding: const EdgeInsets.all(10.0),
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        children: products.map((e) {
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
                                  if(e.values.first =='Shop'){

                                  }
                                  else if(e.values.first=='My Farm'){
                                    if((user_fname==null) && (user_lname==null)){
                                     // await Future.delayed(Duration(microseconds: 2));
                                      await openDialog();
                                    }
                                    else{
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyFarm()),
                                      );
                                    }
                                  }
                                  else if(e.values.first=='Forum'){
                                    print('Forum');

                                  }
                                  else{
                                    print('not');
                                  }
                                },

                                child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        e.values.first,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w800,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: screenHeight * 0.015),
                                      Image.asset(
                                          e.keys.first,
                                          height: 100,
                                          width: screenWidth * 0.9
                                        //  fit: BoxFit.fill,
                                        // height: screenHeight * 0.12,
                                      ),
                                    ]

                                ),
                              )
                          );
                        }
                        ).toList()),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildYourOwnTest(double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(

        margin: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 20.0,
        ),
        // padding: const EdgeInsets.all(10.0),
        height: screenHeight * 0.080,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(FontAwesomeIcons.mapMarkedAlt,
              size: 25,
              color: Color(0xFF73B41A),),
            Container(
              margin:EdgeInsets.only(left:10 ),
              //height: screenHeight * 0.20,
              child: Text(
                'Garden/Farm Mapping',
                style: const TextStyle(
                  color: Color(0xFF737373),
                  fontSize: 16.0,
                  //fontWeight:FontWeight.w800,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
            )
            // Icon(FontAwesomeIcons.mapMarkedAlt,
            //   size: screenHeight * 0.030,
            //   color: Color(0xFF73B41A),),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[
            //
            //     Text(
            //       'Garden/Farm Mapping.',
            //       style: const TextStyle(
            //         color: Color(0xFF737373),
            //         fontSize: 16.0,
            //         //fontWeight:FontWeight.w800,
            //         fontWeight: FontWeight.bold,
            //       ),
            //       maxLines: 2,
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  //display sliding images

  SliverToBoxAdapter _ImageSlider (double screenHeight) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20.0,
        ),
        height: screenHeight * 0.20,
        decoration: BoxDecoration(
          // color: Colors.black,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Container(
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: slideList.length,
                      itemBuilder: (ctx, i) => SlideItem(i),
                    ),
                  ),

                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for(int i = 0; i<slideList.length; i++)
                          if( i == _currentPage )
                            SlideDots(true)
                          else
                            SlideDots(false)
                      ],
                    ),
                  )

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

 openDialog() {

    return showDialog(

        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width:MediaQuery
                  .of(context)
                  .size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        child: Icon(FontAwesomeIcons.infoCircle,
                        color: Color(0xFF73B41A),),
                      ),
                      Container(
                        margin:EdgeInsets.only(left:5),
                        child: Text('Update profile',
                        style: TextStyle(color:Color(0xFF73B41A,),
                        fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),


                  Container(
                      margin: EdgeInsets.only(left: 15.0, top: 10, right: 10.0),
                      child: Text('Please update your profile to access this service',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:Color(0xFF73B41A),
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          //letterSpacing: 2,
                        ),
                      )
                  ),
                  SizedBox(
                      height: 20, // <-- Your width
                  ),
                  Container(
                    //margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    width: 100,
                    height: 30,

                    decoration: BoxDecoration(
                        color: Color(0xFF73B41A) ,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: FlatButton(
                      child: Text('Update',
                        style: TextStyle(
                         color:Color(0xFFFFFFFF)  ,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () {
                       // Navigator.pop(context);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => UserProfile()));

                      },
                    ),
                  ),
                  SizedBox(
                    height: 20, // <-- Your width
                  ),

                ],
              ),
            ),

          );
        });
  }

   var locationns;
   var locationns2;
  String iconImage='';
  String textCondition='';
  double temp=0.0;
  var symbolTemp='°C';
  var urlfn;
  // Future<void> _getLocation() async
  // {
  //   Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   debugPrint('location: ${position.latitude}');
  //   final coordinates = new Coordinates(position.latitude, position.longitude);
  //   var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   var first = addresses.first;
  //   locationns2= first.locality.toLowerCase();
  //   String url2 = ('https://api.v1.agritungo.com/API/weather/$locationns2');
  //   Response response = await get(Uri.parse(url2));
  //   Map dataa= jsonDecode(response.body);
  //   setState(() {
  //     locationns= first.locality;
  //     print(locationns2);
  //     print(dataa);
  //     temp=(dataa['data']['temp']).toDouble();
  //     textCondition=(dataa['data']['text_note']);
  //     iconImage=(dataa['data']['icon']);
  //     urlfn= ('https:$iconImage');
  //     print(urlfn);
  //   });
  // }
  var user_fname;
  var user_lname;
  var userphone;
  var sessionid;
  var accessToken;
  var refreshToken;
  _getPrefs() async {
    SharedPreferences sPrefs = await SharedPreferences.getInstance();
    if(this.mounted){
      setState(() {
        user_fname=sPrefs.getString('first_name');
        user_lname=sPrefs.getString('last_name');
        userphone=sPrefs.getString('phone');
        accessToken= sPrefs.getString('access_token');
        refreshToken= sPrefs.getString('refresh_token');
        sessionid=sPrefs.getInt('session_id');
      });
    }
  }
  //check user registration
  Future<void> _checkUserRegistration() async {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      debugPrint('location: ${position.latitude}');
      final coordinates = new Coordinates(position.latitude, position.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      locationns2= first.locality.toLowerCase();
      String url2 = ('https://api.v1.agritungo.com/API/weather/$locationns2');
      Response response = await get(Uri.parse(url2));
      Map dataa= jsonDecode(response.body);
      if(this.mounted) {
        setState(() {
          locationns = first.locality;
          print(locationns2);
          print(dataa);
          temp = (dataa['data']['temp']).toDouble();
          textCondition = (dataa['data']['text_note']);
          iconImage = (dataa['data']['icon']);
          urlfn = ('https:$iconImage');
          print(urlfn);
        });
      }

  }
  String greetingMessage() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 12) {
      return 'Good Morning';
    } else if ((timeNow > 12) && (timeNow <= 16)) {
      return 'Good Afternoon';
    } else if ((timeNow > 16) && (timeNow < 20)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }


}