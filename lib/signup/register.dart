import 'dart:io';

import 'package:agritungo/signup/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme.dart';
import 'package:http/http.dart';
import'dart:convert';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}
class ListItem{
  int value;
  String image,name;

  ListItem(this.value, this.image, this.name);
}
class _RegisterState extends State<Register> {
  String? _selectedCountryCode = '+256';
  List<String> _countryCodes = ['+256',];
  String? accessToken;
  TextEditingController phoneNumber = TextEditingController();
  bool userPhoneNumber = false;
 // bool isLoading=false;

  bool validateTextField(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        userPhoneNumber = true;
      });
      return false;
    }
    setState(() {

      userPhoneNumber = false;
      String pnumber = phoneNumber.text;
      var finalw = _selectedCountryCode! + pnumber;
      var correctp = finalw.substring(1);
      openDialog();
     // RegisterUser(correctp);

    });
    return true;
  }
//country list
  int _value = 1;
  List<ListItem> _dropdownItems = [
    ListItem(1, "assets/images/flagug.png","Uganda" ),
    // ListItem(2, "assets/images/flagug.png","Kenya" ),
  ];


  @override
  Widget build(BuildContext context) {
    var countryDropDown = Container(
      height: 40,

      decoration: new BoxDecoration(
        // color: Colors.white,
        border: Border(
          right: BorderSide(width: 0.5, color: Colors.black12),
        ),
      ),
      margin: const EdgeInsets.all(3.0),
      //width: 300.0,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            value: _selectedCountryCode,
            items: _countryCodes.map((String value) {
              return new DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Container(
                        child: new Text(
                          value,
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ],
                  ));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCountryCode = value as String?;
              });
            },
            //style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      body: Center(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                    // width: 200,
                      height: 150,
                      /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                      child: Image.asset('assets/images/logo.png')),
                ),
              ),
              SizedBox(height: 20.0),
              // CircleAvatar(
              //   backgroundColor: Color(0xFFFFFFFF),
              //   radius: 32,
              //   child: Icon(Icons.person_pin_rounded, size: 50, color:Color(0xFF73B41A)),
              //
              // ),

              Icon(Icons.person_pin, size: 80,
                  color: Color(0xFF73B41A)),

              Container(
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.black12),
                //   borderRadius: BorderRadius.circular(5.0),
                // ),
                constraints: const BoxConstraints(
                    maxWidth: 500
                ),
                margin: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10),
                child:DropdownButtonFormField(
                  decoration:InputDecoration(
                    // errorText: 'required',
                    contentPadding: EdgeInsets.all(3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.black12, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.black12,),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorStyle: TextStyle(fontSize:10),
                  ),
                  value: _value,
                  items: _dropdownItems.map((ListItem item) {
                    return DropdownMenuItem<int>(
                      child: Row(
                        children: [
                          Image.asset(
                            item.image,
                            width: 25,),
                          Container(margin:EdgeInsets.only(left:5 ),
                              child: Text(item.name,
                                  style: TextStyle(fontSize: 15)))
                        ],
                      ),
                      value: item.value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _value = value as int;
                    });
                  },
                ),

              ),

              Container(
                // width: double.infinity,
                //height: 40,
                constraints: const BoxConstraints(
                    maxWidth: 500
                ),
                margin: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                child: new TextFormField(
                  controller: phoneNumber,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(3),
                    border: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.black12,)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12,),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    errorText: userPhoneNumber
                        ? 'Please enter a phone number'
                        : null,
                    errorStyle: TextStyle(color: Colors.red),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12,),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    //fillColor: Colors.white,
                    prefixIcon: countryDropDown,
                    hintText: '779-586330',
                    hintStyle: TextStyle(color: Colors.black12),

                    // labelText: 'Phone Number'
                  ),
                ),
              ),

              FlatButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: 'By logging into this app, you agree with the ',
                        style: TextStyle(color: Color(0xFF737373))),
                    TextSpan(
                        text: 'Privacy Policy ', style: TextStyle(color: Color(
                        0xFFF9C404),
                        fontWeight: FontWeight.bold)),
                    TextSpan(text: 'and', style: TextStyle(color: Color(
                        0xFF737373))),
                    TextSpan(text: ' Terms & Conditions',

                        style: TextStyle(color: Color(0xFFF9C404),
                            fontWeight: FontWeight.bold
                        )),
                  ]),
                ),
              ),

              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                constraints: const BoxConstraints(
                    maxWidth: 500
                ),
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                    });
                    validateTextField(phoneNumber.text);

                  },
                  color: MyColors.primaryColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    width: double.infinity,

                    child: Text(
                      'Proceed',
                      style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,

                    ),

                  ),

                ),
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'Visit as',
                              style: TextStyle(color: Color(0xFF737373)),
                            ),
                            TextSpan(text: ' Guest',
                              style: TextStyle(color: Color(0xFF73B41A),
                                fontWeight: FontWeight.bold,),
                            )
                          ]
                      )
                  ),
                  Positioned(child: (isLoading)?Center(child: Container(height:26,width: 26,
                      child: CircularProgressIndicator(backgroundColor: Colors.green,))):
                  Container(),right: 30,bottom: 0,top: 0,),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
    RegisterUser(String username) async {
      Map postdata = {
     'username': username
      };

      var json= utf8.encode(jsonEncode(postdata));
      String url = 'https://api.v1.agritungo.com/API/sessions';
      Map<String, String> headers = {
      "Accept": "application/json",
        'Content-Type': 'application/json',
        'Charset': 'utf-8'
      };
      Response response = await post(Uri.parse(url), headers: headers, body: json);
      if (response.statusCode == 201) {

        var dt =response.body;
        print(dt);
        Map data = jsonDecode(response.body);
       accessToken= data['data']['access_token'];
        Fluttertoast.showToast(
            msg: 'Successful',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white
        );
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setInt('session_id', data['data']['session_id']);
        sharedPreferences.setString('access_token', data['data']['access_token']);
        sharedPreferences.setInt('access_token_expires_in', data['data']['access_token_expires_in']);
        sharedPreferences.setString('refresh_token', data['data']['refresh_token']);
        sharedPreferences.setInt('refresh_token_expires_in',  data['data']['refresh_token_expires_in']);
        sharedPreferences.setInt('verifycode', data['data']['verifycode']);
        sharedPreferences.setString('phone', data['data']['number']);
        sharedPreferences.commit();
       }
      else {

        Fluttertoast.showToast(
            msg: 'Please Try again',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white
        );
        print(response.statusCode);
        print(response.body);

      }

    }

   openDialog() {
     String pnumber = phoneNumber.text;
     var finalw = _selectedCountryCode! + pnumber;
     var correctp = finalw.substring(1);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width:MediaQuery
                  .of(context)
                  .size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin:EdgeInsets.only(left: 15),
                        child: Text(
                          "Important",
                           style: TextStyle(fontSize: 24.0,
                           color: Color(0xFF737373)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Divider(
                    color: Color(0xFFF1F1F1),
                    height: 2.0,
                  ),
                  Container(

                    margin: EdgeInsets.only(left: 15.0, top: 5, right: 10.0),
                   child: Text('We will be verifying the number',
                   style: TextStyle(color: Color(0xFF737373),
                     fontSize: 16,
                   ),
                   ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.0, top: 10, right: 10.0),
                    child: Text('$correctp',
                    style: TextStyle(
                      color: Color(0xFF737373),
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      //letterSpacing: 2,
                    ),
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15.0, top: 10, right: 10.0),
                    child: Text('Is this correct, or you would like to edit the number?',
                    style: TextStyle(
                      color: Color(0xFF737373),
                      fontSize: 14,
                      //letterSpacing: 2,
                    ),),

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        //margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.centerLeft,
                        child: FlatButton(
                          child: Text('Edit',
                          style: TextStyle(color: Color(0xFF737373),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          ),
                        ),
                          onPressed: () {
                            Navigator.pop(context, false)  ;
                          },
                        ),
                      ),
                      Container(
                       // alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(left: 70),
                        child: FlatButton(
                          child: Text('Okay',
                          style: TextStyle(color: Color(0xFF73B41A),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),),
                          onPressed: () {
                            RegisterUser(correctp);
                            Navigator.of(context).pop(true);
                            // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Otp(accessTokens: '$accessToken',)), (Route<dynamic> route) => false);
                          },
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),

          );
        }).then((value) {
      if (value == null) return;

      if (value) {
        // user pressed Yes button
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => Otp(accessTokens: '$accessToken',)), (Route<dynamic> route) => false);

      } else {
        // user pressed No button
      }
    });
  }


}


