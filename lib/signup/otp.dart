import 'dart:async';
import 'package:agritungo/dashboard/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../theme.dart';

class Otp extends StatefulWidget {
  final String accessTokens;
  Otp({Key? key, required this.accessTokens}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}
//SharedPreferences sharedPreferences;
final _teOtpDigitOne = TextEditingController();
final _teOtpDigitTwo = TextEditingController();
final _teOtpDigitThree = TextEditingController();
final _teOtpDigitFour = TextEditingController();
String otpWaitTimeLabel = "";
GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool isLoading=false;
int secondsRemaining = 60;
bool enableResend = false;
late Timer timer;
bool onPressedValue=true;
late DateTime _lastQuitTime;

String? accesToken;
String? _refreshToken;
int _phone=0;
int? _sessionId;
class _OtpState extends State<Otp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
       }
        else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }


  void _resendCode() {
    //other code here
    setState((){
      secondsRemaining = 60;
      enableResend = false;
      //ResendOtp(_accesToken, _refreshToken);
      print('hey');
    });
  }
  @override
  dispose(){
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data=  widget.accessTokens;
    return WillPopScope(
      onWillPop: () async{
        if (_lastQuitTime == null ||
            DateTime.now().difference(_lastQuitTime).inSeconds > 1) {
          print('Press again Back Button exit');
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Press again Back Button exit')));          _lastQuitTime = DateTime.now();
          return false;
        } else {
          print('sign out');
          Navigator.of(context).pop(true);
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: _body(context),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(height: 50.0),
        _headerImage(),
        //SizedBox(height:10.0),
        CircleAvatar(
          backgroundColor: Color(0xFF73B41A),
          radius: 38,
          child: Icon(
              FontAwesomeIcons.userShield, size: 45, color: Color(0xFFFFFFFF)),

        ),
        SizedBox(height: 10.0),

        _boxWithLable(context),
        SizedBox(height: 5.0),
        if(secondsRemaining !=0)
          Text(
          'You can resend OTP after $secondsRemaining seconds',
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.black, fontSize: 10),
        ),
        SizedBox(height: 10.0),
        Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           const Text('Didn\'t receive the code?',
           style: TextStyle(color:Color(0xFFA3A3A3),
               fontWeight: FontWeight.bold),),
           FlatButton(
           onPressed:enableResend ? _resendCode : null,
             child: Text('Resend OTP',
             style: TextStyle(color: enableResend? Color(0xFF73B41A) : Colors.grey,
             fontWeight: FontWeight.bold),),
           ),
         ],
        ),

        _bottomButton(context),



      ],
    );
  }


  Widget _boxWithLable(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          //  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            alignment: Alignment.centerLeft,
            child: Center(
              child: Text('OTP VERIFICATION',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF73B41A)
                  )
              ),
            )
        ),
    SizedBox(
      height: 10,
    ),
        Container(
          //  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            alignment: Alignment.centerLeft,
            child: Center(
              child: Text('Enter OTP sent to your number',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color(0xFFA3A3A3)
                  )
              ),
            )


        ),
        _boxBuilder(),
        // SizedBox(
        //   height: 20,
        // )
      ],
    );
  }

  Form _boxBuilder() {
    return Form(
          key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
            alignment: Alignment.center,
            height: 50,
            width: 50,
            child: new TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "required";
                } else
                  return null;
              },
              controller: _teOtpDigitOne,
              //  focusNode: _focusNodeDigitOne,
              onChanged: (_) => FocusScope.of(context).nextFocus(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
               // errorText: 'required',
                contentPadding: EdgeInsets.all(5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black12, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black12,),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.red),
                ),
                errorStyle: TextStyle(fontSize:10),
                counterText: '',
                filled: true,
                fillColor: Colors.white,
              ),

              textAlign: TextAlign.center,
            ),
          ),
          new SizedBox(
            width: 5.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
            alignment: Alignment.center,
            height: 50,
            width: 50,
            child: new TextFormField(
              controller: _teOtpDigitTwo,
              validator: (value) {
                if (value!.isEmpty) {
                  return "required";
                } else
                  return null;
              },
              //focusNode: _focusNodeDigitTwo,
              onChanged: (_) => FocusScope.of(context).nextFocus(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black12, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black12,),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.red),
                ),
                errorStyle: TextStyle(fontSize: 10,),

                counterText: '',
                filled: true,
                fillColor: Colors.white,
              ),

              textAlign: TextAlign.center,
            ),
          ),
          new SizedBox(
            width: 5.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
            alignment: Alignment.center,
            height: 50,
            width: 50,
            child: new TextFormField(
              controller: _teOtpDigitThree,
              validator: (value) {
                if (value!.isEmpty) {
                  return "required";
                } else
                  return null;
              },
              //focusNode: _focusNodeDigitThree,
              onChanged: (_) => FocusScope.of(context).nextFocus(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black12, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black12,),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.red),
                ),
                errorStyle: TextStyle(fontSize: 10),

                counterText: '',
                filled: true,
                fillColor: Colors.white,
              ),

              textAlign: TextAlign.center,
            ),
          ),
          new SizedBox(
            width: 5.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 4),
            alignment: Alignment.center,
            height: 50,
            width: 50,
            child: new TextFormField(
              controller: _teOtpDigitFour,
              validator: (value) {
                if (value!.isEmpty) {
                  return "required";
                } else
                  return null;
              },
              //focusNode: _focusNodeDigitFour,
              onChanged: (_) => FocusScope.of(context).nextFocus(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
              keyboardType: TextInputType.number,
              maxLength: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black12, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black12,),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.red),
                ),
                errorStyle: TextStyle(fontSize: 10),

                counterText: '',
                filled: true,
                fillColor: Colors.white,
              ),

              textAlign: TextAlign.center,
            ),
          ),
          new SizedBox(
            width: 10.0,
          ),

        ],
      ),
    );
  }


  Widget _headerImage() {
    return Container(
      // padding: const EdgeInsets.only(top:30, left:20, right: 20,),
      //  alignment: Alignment.topCenter,
      //margin: EdgeInsets.symmetric(vertical: 45, horizontal:20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      width: double.infinity,

      child: Image.asset(
        "assets/images/logo.png",
        // fit: BoxFit.cover,
        width: MediaQuery
            .of(context)
            .size
            .width * 0.8,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.30,
      ),

    );
  }

  Widget _bottomButton(BuildContext context) {
    return Stack(
      children: [
       Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        constraints: const BoxConstraints(
            maxWidth: 500
        ),
        child: FlatButton(
          child: Text('VERIFY OTP', style: TextStyle(fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Colors.white)),
          onPressed: () {
            if(isLoading)
            {
              return;
            }
            var otpcodes=_teOtpDigitOne.text +
                _teOtpDigitTwo.text +
                _teOtpDigitThree.text +
                _teOtpDigitFour.text;
            if (_formKey.currentState!.validate()) {
              // print("Validated");
              VerifyOtp(otpcodes);
            //  print(otpcodes);
            }else{
              // print("Not Validated");
            }

           // VerifyOtp(otpcodes);
            //print(otpCode);
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const MyHomePage()),
            // );
          },
          color: MyColors.primaryColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),

      ),
        Positioned(child: (isLoading)?Center(child: Container(height:26,width: 26,
            child: CircularProgressIndicator(backgroundColor: Colors.green,))):
        Container(),right: 30,bottom: 0,top: 0,),
       // CircularProgressIndicator(backgroundColor: Colors.green,)
      ]
    );
  }

  VerifyOtp(String otp)async {
    Map postdata = {
      'otp': otp
    };
    setState(() {
      isLoading=true;
    });
     var _acct=widget.accessTokens;
     print(_acct);
    var json = utf8.encode(jsonEncode(postdata));
   // print(json);
    String url = 'https://api.v1.agritungo.com/API/verify';
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-type": "application/json",
      'Authorization': '$_acct',
    };
    Response response = await post(
        Uri.parse(url), headers: headers, body: json);

    if (response.statusCode == 201) {
      setState(() {
        isLoading=false;

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => BoottonNav()), (Route<dynamic> route) => false);
        // Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => const MyHomePage()),
        //     );
      });
      Map data = jsonDecode(response.body);
      print(data);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('status', data['data']['status']);
      sharedPreferences.setString('first_name', data['data']['firstname']);
      sharedPreferences.setString('last_name', data['data']['lastname']);
      sharedPreferences.commit();
      Fluttertoast.showToast(
          msg: 'Successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white
      );

    }
    else{
      setState(() {
        isLoading=false;
      });
      Fluttertoast.showToast(
          msg: 'Please Try again',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white
      );
      print(response.body);
    }
  }
  //resend otp code
  ResendOtp(String token, String refreshToken)async {
    Map postdata1 = {
      'access_token': token,
      'refresh_token': refreshToken,
    };
    var resendJson = utf8.encode(jsonEncode(postdata1));
    String resendurl = 'https://api.v1.agritungo.com/API/verify';
    print(resendJson);
    Map<String, String> headers2 = {
      "Accept": "application/json",
       "Content-type": "application/json",
     'Authorization': '',
    };
    Response response2 = await patch(
        Uri.parse(resendurl), headers: headers2);
    if(response2.statusCode==201){
      Map data2 = jsonDecode(response2.body);
      print(data2);

    }
    else{
      print(response2.body);
    }
  }
}

