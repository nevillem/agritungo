import 'dart:convert';
import 'package:agritungo/dashboard/widgets/bottom_nav.dart';
import 'package:agritungo/dashboard/widgets/profile_form.dart';
import 'package:agritungo/main.dart';
import 'package:agritungo/signup/register.dart';
import 'package:agritungo/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key, required this.fnames, required this.lnames,
    required this.gender, required this.ninumber, required this.dateOfbirth,
    required this.landsize, required this.familyPopulation}) : super(key: key);
  final String fnames, lnames,  ninumber,gender, dateOfbirth;
  final String landsize, familyPopulation;

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}
 GlobalKey<FormState> _completePformKey = GlobalKey<FormState>();

TextEditingController _village = TextEditingController();
class _CompleteProfileState extends State<CompleteProfile> {
  String? _countrySelection;
  List<Map> _myJson = [{"id":1,"name":"Uganda"}];
  bool isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    _village.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
     // resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text('Complete User Profile'),
          titleTextStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 20,),
          elevation: 0,
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:(){
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UserProfile()));
              },
          )
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
         child: _completeprofile(screenHeight, screenwidth),
      ),
    );
  }

  Form _completeprofile(double screenHeight, double screenwidth) {
    return Form(
        key: _completePformKey,
        child: Container(
          margin: EdgeInsets.only(left:20, right: 20, top: 5),
          child: PhysicalModel(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            elevation: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
                  child: Text(
                    'Country *',
                    style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
                      color: Color(0xFF737373),),
                  ),
                ),
                SizedBox(
                  height:4,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10, right: 10,),
                  child:DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      // errorText: 'required',
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12,),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      errorStyle: TextStyle(fontSize:10),
                      filled: true,
                      fillColor: Colors.white,

                    ),
                    isDense: true,
                    hint: new Text("Select Country"),
                    value: _countrySelection,
                    onChanged: (String? newValue) {
                      setState(() {
                        _countrySelection = newValue;
                        _myRegions=null;
                             _getStateList();
                      });

                     // print (_countrySelection);
                    },
                      validator: (value) {
                        if (value ==null) {
                          return "required";
                        } else
                          return null;
                      },
                    items: _myJson.map((Map map) {
                      return new DropdownMenuItem<String>(
                        value: map["id"].toString(),
                        child: new Text(
                          map["name"],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
                  child: Text(
                    'Region *'
                        '',
                    style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
                      color: Color(0xFF737373),

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
                  child:DropdownButtonFormField<String>(
                    decoration:InputDecoration(
                      // errorText: 'required',
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12,),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      errorStyle: TextStyle(fontSize:10),
                    ),
                    value: _myRegions,
                    iconSize: 30,
                    icon: (null),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint: Text('Select Region'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _myRegions = newValue;
                        _mydistrict=null;
                        _getDistrict();
                        print(_myRegions);
                      });
                    },
                      validator: (value) {
                        if (value ==null) {
                          return "required";
                        } else
                          return null;
                      },
                    items: regionsList?.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    })?.toList() ??
                        [],

                  )

                ),
                Container(
                  margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
                  child: Text(
                    'District *'
                        '',
                    style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
                      color: Color(0xFF737373),

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
                  child:DropdownButtonFormField<String>(
                    decoration:InputDecoration(
                      // errorText: 'required',
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12,),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      errorStyle: TextStyle(fontSize:10),
                    ),
                    value: _mydistrict,
                    iconSize: 30,
                    icon: (null),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint: Text('Select District'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _mydistrict = newValue;
                        _myCounties=null;
                        _getCounties();
                        print(_mydistrict);
                      });
                    },
                      validator: (value) {
                        if (value ==null) {
                          return "required";
                        } else
                          return null;
                      },
                    items: districtList?.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    })?.toList() ??
                        [],

                  )

                ),
            Container(
                  margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
                  child: Text(
                    'County *'
                        '',
                    style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
                      color: Color(0xFF737373),

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
                  child:DropdownButtonFormField<String>(
                    decoration:InputDecoration(
                      // errorText: 'required',
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12,),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      errorStyle: TextStyle(fontSize:10),
                    ),
                    value: _myCounties,
                    iconSize: 30,
                    icon: (null),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint: Text('Select County'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _myCounties = newValue;
                        _mysubCounties=null;
                        _getSubcounites();
                        // print(_myCounties);
                      });
                    },
                      validator: (value) {
                        if (value ==null) {
                          return "required";
                        } else
                          return null;
                      },
                    items: countiesList?.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    })?.toList() ??
                        [],

                  )

                ),

                Container(
                  margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
                  child: Text(
                    'Sub County *'
                        '',
                    style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
                      color: Color(0xFF737373),

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
                  child:DropdownButtonFormField<String>(
                    decoration:InputDecoration(
                      // errorText: 'required',
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12,),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      errorStyle: TextStyle(fontSize:10),
                    ),
                    value: _mysubCounties,
                    iconSize: 30,
                    icon: (null),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint: Text('Select sub county'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _mysubCounties = newValue;
                        _myParish=null;
                        _getParishes();
                        print(_mysubCounties);
                      });
                    },
                      validator: (value) {
                        if (value ==null) {
                          return "required";
                        } else
                          return null;
                      },
                    items: subcountiesList?.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    })?.toList() ??
                        [],

                  )

                ),
              Container(
                  margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
                  child: Text(
                    'Parish *'
                        '',
                    style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
                      color: Color(0xFF737373),

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
                  child:DropdownButtonFormField<String>(
                    decoration:InputDecoration(
                      // errorText: 'required',
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12,),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      errorStyle: TextStyle(fontSize:10),
                    ),
                    value: _myParish != null ? _myParish : null,
                    iconSize: 30,
                    icon: (null),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    hint: Text('Select Parish'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _myParish = newValue;
                        print('parishid:$_myParish');
                      });
                    },
                    validator: (value) {
                      if (value ==null) {
                        return "required";
                      } else
                        return null;
                    },
                    items: parishList?.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item['name']),
                        value: item['id'].toString(),
                      );
                    })?.toList() ??
                        [],

                  )

                ),


                Container(
                  margin: EdgeInsets.only(left: 15, top: 10, right: 10,),
                  child: Text(
                    'Village *',
                    style: TextStyle(fontWeight:FontWeight.normal, fontSize: 14,
                      color: Color(0xFF737373),

                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "required";
                      } else
                        return null;
                    },
                    controller: _village,
                    keyboardType: TextInputType.text,
                   // textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.black12,),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      errorStyle: TextStyle(fontSize:10),
                      filled: true,
                      fillColor: Colors.white,

                    ),
                  ),
                ),

                Stack(
                  children: [
                   Container(
                   alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 30, top: 10, bottom: 10),
                    child: FlatButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      color: Color(0xFF73B41A),
                      child: Text('Finish',
                        style: TextStyle(color: Color(0xFFFFFFFF),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),),

                      onPressed: () {
                        if(isLoading)
                        {
                          return;
                        }
                        if (_completePformKey.currentState!.validate()) {
                          var fname= widget.fnames;
                          var lname= widget.lnames;
                          // var pnumber= widget.telphoneN;
                          var numbern= widget.ninumber;
                          var gender= widget.gender;
                          print('sez' + gender);
                          //extract dateonly
                          var doBirth= widget.dateOfbirth;
                          var inputDate = DateTime.parse(doBirth);
                          var outputFormat = DateFormat('yyyy-MM-dd');
                          //final date
                          var outputDate = outputFormat.format(inputDate);
                          var landsizee= widget.landsize;
                          var fmilypop =widget.familyPopulation;
                          print(outputDate);
                          updateUsers(lname,fname, gender,numbern,outputDate,
                              landsizee,fmilypop, _village.text, _myParish);
                          // Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (context) => CompleteProfile()
                          //     )
                          // );
                        }
                        else{


                        }

                      },
                    ),
                  ),
                    Positioned(child: (isLoading)?Center(child: Container(height:26,width: 26,
                        child: CircularProgressIndicator(backgroundColor: Colors.green,))):
                    Container(),right: 30,bottom: 0,top: 0,),
                 ]
                ),

                new SizedBox(
                  width: 10.0,
                ),
                // Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
              ],
            ),
          ),
        )

    );
  }

  //CALLING STATE API HERE
// Get State information by API
  List? regionsList;
  String? _myRegions;

  _getStateList() async {
    String countryInfoUrl = 'https://api.v1.agritungo.com/API/region/$_countrySelection';
    await get(Uri.parse(countryInfoUrl)).then((response) {
      var data = json.decode(response.body);
     // print(data);
      setState(() {
        regionsList = data['data']['regions'];
      });
    });
  }
  List? districtList;
  String? _mydistrict;
 _getDistrict() async {
    String countryInfoUrl = 'https://api.v1.agritungo.com/API/districts/$_myRegions';
    await get(Uri.parse(countryInfoUrl)).then((response) {
      var data = json.decode(response.body);
      setState(() {
        districtList = data['data']['districts'];
      });
    });
  }
List? countiesList;
  String? _myCounties;
 _getCounties() async {
    String countryInfoUrl = 'https://api.v1.agritungo.com/API/counties/$_mydistrict';
    await get(Uri.parse(countryInfoUrl)).then((response) {
      var data = json.decode(response.body);
     // print(data);
      setState(() {
        countiesList = data['data']['counties'];
      });
    });
  }
List? subcountiesList;
  String? _mysubCounties;
 _getSubcounites() async {
    String countryInfoUrl = 'https://api.v1.agritungo.com/API/subcounties/$_myCounties';
    await get(Uri.parse(countryInfoUrl)).then((response) {
      var data = json.decode(response.body);
      //print(data);
      setState(() {
        subcountiesList = data['data']['subcounty'];
      });
    });
  }
  List? parishList;
  String? _myParish;
 _getParishes() async {
    String countryInfoUrl = 'https://api.v1.agritungo.com/API/parishes/$_mysubCounties';
    await get(Uri.parse(countryInfoUrl)).then((response) {
      var data = json.decode(response.body);
    //  print(data);
      setState(() {
        parishList = data['data']['parish'];
      });
    });
  }

  var accessToken;
 var refreshToken;
 var sessionId;
  String url = ('https://api.v1.agritungo.com/API/users');
  getPrefs() async {
    SharedPreferences prefs  = await SharedPreferences.getInstance();
    print(widget.fnames);
    setState(() {
      accessToken = prefs.getString('access_token');
      refreshToken = prefs.getString('refresh_token');
      sessionId = prefs.getInt('session_id');
      print(accessToken);
    });
  }

  updateUsers(String  lname, fname, gender, ninnumber, dateofB,
      landsizes, familyPop, village, parish  ) async {
    setState(() {
      isLoading=true;
    });
    Map<String, String> headerfinal = {
      "Accept": "application/json",
      "Content-type": "application/json",
      'Authorization': '$accessToken',
    };
    Map postdata1 = {
      'lastname': lname,
      'firstname': fname,
      'gender': gender,
      'nin': ninnumber,
      'dob': dateofB,
      'landsize': landsizes,
      'population': familyPop,
      'village': village,
      'parish': parish,
    };
    print('this is $fname');
    var updateProfile = utf8.encode(jsonEncode(postdata1));
    print(jsonEncode(postdata1));
    Response response3 = await patch(
        Uri.parse(url), headers: headerfinal, body: updateProfile);
     Map profiledata= jsonDecode(response3.body);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(response3.statusCode==201){
      print('update message' + response3.body);
      setState(() {
        isLoading=false;
        sharedPreferences.setString('first_name', profiledata['data']['firstname']);
        sharedPreferences.setString('last_name', profiledata['data']['lastname']);
        sharedPreferences.commit();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BoottonNav()),
        );
      });
      Fluttertoast.showToast(
          msg: 'Profile Updated',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.green,
          textColor: Colors.white
      );
     }
    else if(response3.statusCode==500){
      print("You have not made any changes");
      setState(() {
        isLoading=false;
      });
      Fluttertoast.showToast(
          msg: 'You have not made any changes',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.red,
          textColor: Colors.white
      );
    }
    else{
      setState(() {
        isLoading=false;
      });
      Fluttertoast.showToast(
          msg: 'Failed to Update profile',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: Colors.red,
          textColor: Colors.white
      );
      print(response3.body);
      print(response3.statusCode);
    }
  }
}
