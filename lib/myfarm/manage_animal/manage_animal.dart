
import 'dart:convert';
import 'package:agritungo/catalog/animal_breeds/breed_model/models_b.dart';
import 'package:agritungo/signup/register.dart';
import 'package:agritungo/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'manage_animal_form.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ManageAnimalMain extends StatefulWidget {
  const ManageAnimalMain({Key? key}) : super(key: key);

  @override
  _ManageAnimalMainState createState() => _ManageAnimalMainState();
}
class _ManageAnimalMainState extends State<ManageAnimalMain> {
  TextEditingController colorName = TextEditingController();
  TextEditingController _dateC = TextEditingController();
  TextEditingController _bDate = TextEditingController();
  GlobalKey<FormState> _addAnimal = GlobalKey<FormState>();
  String? _myselect;
  List<Map> _selectGender = [{"gender":"Male"}, {"gender":"Female"}];
  var accessToken;
  var refreshToken;
  var sessionid;
  File? image;
  final picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPrefs();
    _getAnimals();
    _getColors();
    _getBreeds();
    _getStalls();
  }
  List <BreedModel> breedModel = [];
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text('Manage Animals'),
          titleTextStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 20,),
          elevation: 5,
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() {
              Navigator.pop(context, false);
              _getPrefs();
            }
          )
      ),
      body: RefreshIndicator(
        onRefresh: _getAnimals,
        child: Container(
          child: loading
              ? Center(child: CircularProgressIndicator(
            valueColor:AlwaysStoppedAnimation<Color>(Color(0xFF73B41A)),
          )): Container(
            // margin: EdgeInsets.only(left:20, right: 20,),
            child: _bodyDataTable(),

          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF73B41A),
        onPressed: () {
          ManageAnimalDialog(context,  accessToken, refreshToken,sessionid);
        },
        child: Icon(Icons.add),
      ),
    );
  }
  SingleChildScrollView _bodyDataTable(){
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:Container(
            margin: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.black12,
                width: 1, //                   <--- border width here
              ),
            ),
            child: dataBody(),
          ),

        )
    );
  }
  DataTable dataBody() {
    return DataTable(
      sortAscending: true,
      sortColumnIndex: 0,
      columnSpacing: 50,
      columns: [
        // DataColumn(
        //     label: Text('#',
        //         style: TextStyle(
        //             fontWeight: FontWeight.w800,
        //             fontSize: 15,
        //             color: Color(0xFF737373)
        //         )
        //     ),
        //     numeric: false,
        //     tooltip: "id"
        // ),
        DataColumn(label: Text('Breed name',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: Color(0xFF737373)
            )),
            numeric: false,
            tooltip: "This is breed name"),
        DataColumn(label: Text('')),
        DataColumn(label: Text('Action',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: Color(0xFF737373)
          ),),
            numeric: false,
            tooltip: "do action"),
      ],
      rows: breedModel.map((e) =>
          DataRow(
            selected: breedModel.indexOf(e) % 2 == 0 ? true : false,

            cells: [
              // DataCell(Center(
              //   // child: Text(
              //   //     e.id ,
              //   //     style: TextStyle(
              //   //         fontWeight: FontWeight.normal,
              //   //         fontSize: 15,
              //   //         color: Color(0xFF737373)
              //   //     )
              //   // ),
              // )),
              DataCell(Center(
                child: Text(
                    e.colorName.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Color(0xFF737373)
                    )
                ),
              )),

              DataCell(Text('Edit',
                style: TextStyle(color: Color(0xFF73B41A),
                  fontWeight: FontWeight.normal,
                  fontSize: 15,),
              ),
                onTap: () {
                  print(e.id);
                  var breedid = e.id;
                  var breedNamees = e.colorName;
                  _updatecomfirmBreeds(breedid, breedNamees).then((_)=>setState((){
                    _getAnimals();
                    _getPrefs();
                  }));
                },
              ),
              DataCell(
                  Text('Delete',
                    style: TextStyle(color: Color(0xFFF00000),
                      fontWeight: FontWeight.normal,
                      fontSize: 15,),
                  ),
                  onTap: () {
                    var colorId = e.id;
                    _showConfirmationDialog(colorId).then((_)=>setState((){
                      _getAnimals();
                      _getPrefs();
                    }));
                  }
              ),
            ],

          )
      ).toList(),
    );
  }
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

  Future<void> _getAnimals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(this.mounted){
      setState(() {
        accessToken= prefs.getString('access_token');
        refreshToken= prefs.getString('refresh_token');
        sessionid= prefs.getInt('session_id');
      });
    }
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-type": "application/json",
      'Authorization': '$accessToken',
    };
    print('mmmmmmm' + accessToken);
    var url = Uri.parse('https://api.v1.agritungo.com/API/catalog/breed');
    var response = await http.get((url), headers: header);
    Map<String, dynamic> datas = jsonDecode(response.body);
    List finalData = datas['data']['breed'];
    List<BreedModel> tempdata = finalData.map((tagJson) => BreedModel.fromJson(tagJson)).toList();

    print(response.body);

    if (response.statusCode == 401) {
      print(response.body);
      Map _refreshLogin = {
        'refresh_token': refreshToken,
      };
      var _json = utf8.encode(jsonEncode(_refreshLogin));
      String urlRefresh = ('https://api.v1.agritungo.com/API/sessions/$sessionid');
      var responseRefresh = await http.patch(
          Uri.parse(urlRefresh), headers: header, body: _json);
      Map data = json.decode(responseRefresh.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (responseRefresh.statusCode == 200) {
        print(data);
        print('new refresh breeds' + data['data']['refresh_token']);
        prefs.setString('access_token', data['data']['access_token']);
        prefs.setString('refresh_token', data['data']['refresh_token']);
        prefs.reload();
        var newAccessToken = data['data']['access_token'];
        Map<String, String> newHeader = {
          "Accept": "application/json",
          "Content-type": "application/json",
          'Authorization': '$newAccessToken',
        };
        var finalResponse = await http.get((url), headers: newHeader);
        Map<String, dynamic> dataa = jsonDecode(finalResponse.body);
        List finalDataa = dataa['data']['breed'];
        List<BreedModel> tempdata2 = finalDataa.map((tagJson) =>
            BreedModel.fromJson(tagJson)).toList();
        setState(() {
          breedModel = tempdata2;
          loading = false;
        });
      }
      else if (responseRefresh.statusCode == 401) {
        prefs.clear();
        print('refreshtokenerror' + responseRefresh.body);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => Register()),
                (Route<dynamic> route) => false);
      }
      else {
        print('other access errors on manage breeds');
        print(responseRefresh.statusCode);
      }
    } else if(response.statusCode==200){
      if (this.mounted) {
        setState(() {
          breedModel = tempdata;
          loading = false;
        });
      }
    }
    else{
      setState(() {
        loading=false;
      });
    }
  }

  //delete
  Future<bool> _showConfirmationDialog(String itemId) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm"),
          content: const Text("Are you sure you want to delete this color?"),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  print(itemId);
                  _deleteBreedNo(itemId);
                  Navigator.of(context).pop(true);
                },
                child: const Text("DELETE")
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
    );
  }

  _deleteBreedNo(String breedId) async {
    print('breed: $breedId');
    String url = 'https://api.v1.agritungo.com/API/catalog/breed/$breedId';
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-type": "application/json",
      'Authorization': '$accessToken',
    };
    print(accessToken);
    Response dResponse = await delete(Uri.parse(url), headers: headers);

    if (dResponse.statusCode == 401) {
      Map _refreshLogin = {
        'refresh_token': refreshToken,
      };
      var _json = utf8.encode(jsonEncode(_refreshLogin));
      String urlRefresh = ('https://api.v1.agritungo.com/API/sessions/$sessionid');
      var responseRefresh = await http.patch(
          Uri.parse(urlRefresh), headers: headers, body: _json);
      Map data = json.decode(responseRefresh.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (responseRefresh.statusCode == 200) {
        print(data);
        print('new refresh breed' + data['data']['refresh_token']);
        prefs.setString('access_token', data['data']['access_token']);
        prefs.setString('refresh_token', data['data']['refresh_token']);
        prefs.reload();
        var newAccessToken = data['data']['access_token'];
        Map<String, String> newHeaders = {
          "Accept": "application/json",
          "Content-type": "application/json",
          'Authorization': '$newAccessToken',
        };
        String url2 = 'https://api.v1.agritungo.com/API/catalog/breed/$breedId';
        Response dResponse2 = await delete(
            Uri.parse(url2), headers: newHeaders);
        if (dResponse2.statusCode == 201) {
          Fluttertoast.showToast(
              msg: 'Deleted Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.green,
              textColor: Colors.white
          );
          _getAnimals();
          _getPrefs();
        }
      } else if (responseRefresh.statusCode == 401) {
        prefs.clear();
        print('refreshtokenerror' + responseRefresh.body);
      }
    }
    else if (dResponse.statusCode == 201) {
      Fluttertoast.showToast(
          msg: 'Deleted Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white
      );
      _getAnimals();
      _getPrefs();
    }
  }
//update breeds
  Future<bool> _updatecomfirmBreeds( String itemId, String breedName) async {
    TextEditingController breedNo = TextEditingController()..text=breedName;

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
              width:MediaQuery
                  .of(context)
                  .size.width * 10,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin:EdgeInsets.only(left: 15),
                          child: Text(
                            "Update Breeds",
                            style: TextStyle(fontSize: 15.0,
                                fontWeight: FontWeight.bold,
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
                      height: 3.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15.0, top: 10, right: 10.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Add new Name to update";
                          } else
                            return null;
                        },
                        controller: breedNo,
                        decoration:InputDecoration(
                          // errorText: 'required',
                          hintText: 'Color Name',
                          hintStyle: TextStyle(color: Colors.black12),
                          isDense: true,
                          contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
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
                      ),

                    ),
                    SizedBox(height: 10,),
                  ]
              )
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  print(itemId);
                  _updateBreed(itemId, breedNo.text);
                  Navigator.of(context).pop(true);

                },
                child: const Text("UPDATE")
            ),
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text("CANCEL"),
            ),
          ],
        );
      },
    );
  }
  _updateBreed(String itemId, String breedName) async{
    Map postdata = {
      "breedname": "$breedName"
    };
    print('color: $breedName');
    var _json= utf8.encode(jsonEncode(postdata));
    String urlupdate = 'https://api.v1.agritungo.com/API/catalog/breed/$itemId';
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json',
      'Authorization': '$accessToken',
    };
    if(breedName==''){
      Fluttertoast.showToast(
          msg: 'Please enter Color Name',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white
      );
    }
    else{
      Response responseupdate = await patch(Uri.parse(urlupdate), headers: headers, body: _json);
      if(responseupdate.statusCode==401) {
        Map _refreshLogin = {
          'refresh_token': refreshToken,
        };
        var _json2 = utf8.encode(jsonEncode(_refreshLogin));
        String urlRefresh = ('https://api.v1.agritungo.com/API/sessions/$sessionid');
        Response responseRefresh = await patch(
            Uri.parse(urlRefresh), headers: headers, body: _json2);
        Map data = jsonDecode(responseRefresh.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (responseRefresh.statusCode == 200) {
          print(data);
          print('new refresh' + data['data']['refresh_token']);
          prefs.setString('access_token', data['data']['access_token']);
          prefs.setString('refresh_token', data['data']['refresh_token']);
          prefs.reload();
          print('new accessToken' + data['data']['access_token']);
          var newAccess=data['data']['access_token'];
          Map<String, String> headerResponse = {
            "Accept": "application/json",
            'Content-Type': 'application/json',
            'Authorization': '$newAccess',
          };
          Response responseupdatee = await patch(Uri.parse(urlupdate), headers: headerResponse, body: _json);
          if(responseupdatee.statusCode==200){
            Fluttertoast.showToast(
                msg: 'Successfully Updated',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white
            );
            _getAnimals();
            _getPrefs();

          }
          else if(responseupdatee.statusCode==409){
            Fluttertoast.showToast(
                msg: 'Please you\'re updating same data',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white
            );
          }
          else{
            print('responsee error'+ responseupdatee.body);
            print(responseupdatee.statusCode);
            Fluttertoast.showToast(
                msg: 'Please Try again',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white
            );
          }
        }else if(responseRefresh.statusCode==401){
          prefs.clear();
          print('refreshtokenerror' + responseRefresh.body);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Register()),
                  (Route<dynamic> route) => false);
        }
      }
      else if(responseupdate.statusCode==200){
        print(responseupdate.body);
        Fluttertoast.showToast(
            msg: 'Successfully Updated',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white
        );
        _getAnimals();
        _getPrefs();
      }else if(responseupdate.statusCode==400){
        print(responseupdate.body);

        Fluttertoast.showToast(
            msg: 'Please you\'re updating same data',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white
        );
      }
      else{
        print('responsee error'+ responseupdate.body);
        Fluttertoast.showToast(
            msg: 'Please Try again',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white
        );
      }
    }
  }
  ManageAnimalDialog(BuildContext context, String accessTokens, refreshTokens, sessionid) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {

          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  insetPadding: EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  content: Container(
                    width:MediaQuery
                        .of(context)
                        .size.width * 10,
                    child: SingleChildScrollView(
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
                                  "Animal Basic Information",
                                  style: TextStyle(fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
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

                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 5),
                                width:150,
                                child:TextFormField(
                                  validator: (value) {
                                    if (value ==null) {
                                      return "required";
                                    } else
                                      return null;
                                  },
                                  controller: _dateC,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.calendar_today),
                                    hintText: 'Date of Birth',//Gicon of text field
                                    hintStyle: TextStyle(fontSize: 12),
                                    // errorText: 'required',
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
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

                                  ),            readOnly: true,  //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context, initialDate: DateTime(2010),
                                        firstDate: DateTime(1945), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2010)
                                    );

                                    if(pickedDate != null ){
                                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                      //you can implement different kind of Date Format here according to your requirement
                                      setState(() {
                                        _dateC.text = formattedDate; //set output date to TextField value.
                                      });
                                    }else{
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 5),
                                width: 150,
                                child: TextFormField(
                                  decoration:InputDecoration(
                                    // errorText: 'required',
                                    hintText: 'Animal Age(months)',
                                    hintStyle: TextStyle(color: Colors.black26, fontSize: 13),
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
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
                                    filled: true,
                                    fillColor: Colors.black12,
                                  ),
                                ),

                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 5),
                                width: 150,
                                child: TextFormField(
                                  decoration:InputDecoration(
                                    // errorText: 'required',
                                    hintText: 'Weight',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
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
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),

                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 5),
                                width: 150,
                                child: TextFormField(
                                  decoration:InputDecoration(
                                    // errorText: 'required',
                                    hintText: 'Height',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
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
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),

                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 5),
                                width: 150,
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
                                  isDense: true,
                                  hint: new Text("Choose Gender",
                                      style: TextStyle(fontSize: 12),),
                                 value: _myselect,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _myselect = newValue;
                                      _getPregnancyOption();
                                      //_pregnacyStatus=null;
                                    });
                                    // print (_countrySelection);
                                  },
                                  validator: (value) {
                                    if (value ==null) {
                                      return "required";
                                    } else
                                      return null;
                                  },
                                  items: _selectGender.map((Map map) {
                                    return new DropdownMenuItem<String>(
                                      value: map["gender"].toString(),
                                      child: new Text(
                                        map["gender"],
                                      ),
                                    );
                                  }).toList(),
                                ),

                              ),
                              Container(
                                width: 150,
                                  margin: EdgeInsets.only(left: 10, top: 5),
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
                                    value: _myColors,
                                    iconSize: 30,
                                    icon: (null),
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                    ),
                                    hint: Text('Colors',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _myColors = newValue;
                                        print(_myColors);
                                      });
                                    },
                                    validator: (value) {
                                      if (value ==null) {
                                        return "required";
                                      } else
                                        return null;
                                    },
                                    items: colorsList?.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['name']),
                                        value: item['id'].toString(),
                                      );
                                    })?.toList() ??
                                        [],

                                  )

                              ),
                            ],
                          ),
                       Row(
                            children: [
                              Container(
                                width: 150,
                                  margin: EdgeInsets.only(left: 10, top: 5),
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
                                    value: _myBreed,
                                    iconSize: 30,
                                    icon: (null),
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                    ),
                                    hint: Text('Animal Breed',
                                    style: TextStyle(fontSize: 12),),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _myBreed = newValue;
                                        print(_myBreed);
                                      });
                                    },
                                    validator: (value) {
                                      if (value ==null) {
                                        return "required";
                                      } else
                                        return null;
                                    },
                                    items: breedList?.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['name']),
                                        value: item['id'].toString(),
                                      );
                                    })?.toList() ??
                                        [],

                                  )

                              ),
                                Container(
                                width: 150,
                                  margin: EdgeInsets.only(left: 10, top: 5),
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
                                    value:_pregnacyStatus,
                                    iconSize: 30,
                                    icon: (null),
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                    ),
                                    hint: Text('Pregnance Status',
                                    style: TextStyle(fontSize: 12),),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _pregnacyStatus = newValue;
                                        print(_pregnacyStatus);
                                      });
                                    },
                                    validator: (value) {
                                      if (value ==null) {
                                        return "required";
                                      } else
                                        return null;
                                    },
                                    items:listPregnancy?.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['option']),
                                        value: item['option'].toString(),
                                      );
                                    })?.toList() ??
                                        [],

                                  )

                              ),

                            ],
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5, right:20),
                            child:TextFormField(
                              validator: (value) {
                                if (value ==null) {
                                  return "required";
                                } else
                                  return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.calendar_today),
                                hintText: 'Next Pregnancy Approx Time',
                                hintStyle: TextStyle(fontSize: 12),//icon of text field
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
                              readOnly: true,  //set it true, so that user will not able to edit text
                               onTap: () async {
                                if(_myselect=="Female"){
                                DateTime? pickedDate = await showDatePicker(
                                    context: context, initialDate: DateTime(2010),
                                    firstDate: DateTime(1945), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2010)
                                );

                                if(pickedDate != null ){
                                  print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                  //you can implement different kind of Date Format here according to your requirement
                                  setState(() {
                                    _dateC.text = formattedDate; //set output date to TextField value.
                                  });
                                }else{
                                  print("Date is not selected");
                                }
                              }
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 5),
                                width: 150,
                                child: TextFormField(
                                  decoration:InputDecoration(
                                    // errorText: 'required',
                                    hintText: 'Litres Per Day',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
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
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),

                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 5),
                                width: 150,
                                child: TextFormField(
                                  decoration:InputDecoration(
                                    // errorText: 'required',
                                    hintText: 'Bought From',
                                    hintStyle: TextStyle(color: Colors.black26),
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
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
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),

                              ),
                            ],
                          ),
                          SizedBox(height: 10,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:<Widget> [
                              Container(
                                //margin: EdgeInsets.only(top: 10),
                                alignment: Alignment.centerLeft,
                                child: FlatButton(
                                  color: Color(0xFF737373),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: Text('Cancel',
                                    style: TextStyle(color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              Container(
                                // alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(left: 70),
                                child: FlatButton(
                                  color: Color(0xFF73B41A),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: Text('Next',
                                    style: TextStyle(color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                    nextDialog(context, accessTokens,refreshTokens,sessionid);

                                  },
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 20,),

                        ],
                      ),
                    ),
                  ),

                );
              }
          );
        });
  }

  nextDialog(BuildContext context, String accessTokens, refreshTokens, sessionid) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  insetPadding: EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  content: Container(
                    width:MediaQuery
                        .of(context)
                        .size.width * 10,
                    child: SingleChildScrollView(
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
                                  "Complete Animal Information",
                                  style: TextStyle(fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
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
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 5),
                                width: 150,
                                child: TextFormField(
                                  decoration:InputDecoration(
                                    // errorText: 'required',
                                    hintText: 'Buying Price',
                                    hintStyle: TextStyle(color: Colors.black26, fontSize: 12),
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
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
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),

                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 5),
                                width:150,
                                child:TextFormField(
                                  validator: (value) {
                                    if (value ==null) {
                                      return "required";
                                    } else
                                      return null;
                                  },
                                  controller: _bDate,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.calendar_today),
                                    hintText: 'Buy Date',//Gicon of text field
                                    hintStyle: TextStyle(fontSize: 12),
                                    // errorText: 'required',
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
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

                                  ),            readOnly: true,  //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context, initialDate: DateTime(2010),
                                        firstDate: DateTime(1945), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2010)
                                    );

                                    if(pickedDate != null ){
                                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                      //you can implement different kind of Date Format here according to your requirement
                                      setState(() {
                                        _bDate.text = formattedDate; //set output date to TextField value.
                                      });
                                    }else{
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  width: 150,
                                  margin: EdgeInsets.only(left: 10, top: 5),
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
                                    value: _myStall,
                                    iconSize: 30,
                                    icon: (null),
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                    ),
                                    hint: Text('Stall',
                                      style: TextStyle(fontSize: 12),),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _myStall= newValue;
                                        print(_myStall);
                                      });
                                    },
                                    validator: (value) {
                                      if (value ==null) {
                                        return "required";
                                      } else
                                        return null;
                                    },
                                    items: stallList?.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['name']),
                                        value: item['id'].toString(),
                                      );
                                    })?.toList() ??
                                        [],

                                  )

                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 5),
                                width: 150,
                                child: TextFormField(
                                  decoration:InputDecoration(
                                    // errorText: 'required',
                                    hintText: 'Animal Tag No',
                                    hintStyle: TextStyle(color: Colors.black26, fontSize: 12),
                                    isDense: true,
                                    contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
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
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),

                              ),
                            ],
                          ),

                          Container(
                            margin: EdgeInsets.only(left: 15.0, top: 10, right: 10.0),
                            child: TextFormField(
                              decoration:InputDecoration(
                                // errorText: 'required',
                                hintText: 'Phone number',
                                hintStyle: TextStyle(color: Colors.black26),
                                isDense: true,
                                contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
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
                            ),

                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15.0, top: 10, right: 10.0),
                            child: TextFormField(
                              decoration:InputDecoration(
                                // errorText: 'required',
                                hintText: 'Notes',
                                hintStyle: TextStyle(color: Colors.black26, fontSize: 12),
                                isDense: true,
                                contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
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
                            ),

                          ),

                          Container(
                            margin: EdgeInsets.only(left: 15.0, top: 10, right: 10.0),
                            child: TextFormField(
                              decoration:InputDecoration(
                                // errorText: 'required',
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.black26),
                                isDense: true,
                                contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
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
                            ),

                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15.0, top: 10, right: 10.0),
                            child: RaisedButton.icon(
                              onPressed: (){
                                pickImageFromGallery(ImageSource.gallery); // call choose image function
                              },
                              icon:Icon(Icons.folder_open),
                              label: Text("CHOOSE IMAGE"),
                              color: Colors.deepOrangeAccent,
                              colorBrightness: Brightness.dark,
                            ),
                          ),


                          SizedBox(height: 10,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:<Widget> [
                              Container(
                                //margin: EdgeInsets.only(top: 10),
                                alignment: Alignment.centerLeft,
                                child: FlatButton(
                                  color: Color(0xFF737373),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: Text('Back',
                                    style: TextStyle(color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    ManageAnimalDialog(context, accessTokens, refreshTokens, sessionid);
                                    print("check on cancel $accessTokens");
                                  },
                                ),
                              ),
                              Container(
                                // alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(left: 70),
                                child: FlatButton(
                                  color: Color(0xFF73B41A),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  child: Text('Save',
                                    style: TextStyle(color: Color(0xFFFFFFFF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),),
                                  onPressed: () {
                                    print(sessionid);
                                    print(accessTokens);

                                  },
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 20,),

                        ],
                      ),
                    ),
                  ),

                );
              }
          );
        });
  }

  List? colorsList;
  String? _myColors;
  _getColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      accessToken=prefs.getString('access_token');
    print('colors' + accessToken);
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-type": "application/json",
      'Authorization': '$accessToken',
    };
    String countryInfoUrl = 'https://api.v1.agritungo.com/API/catalog/color';
    await get(Uri.parse(countryInfoUrl), headers:header ).then((response) {
      var dataColor = json.decode(response.body);
      setState(() {
        colorsList = dataColor['data']['colors'];
      });
    });
  }
  List? breedList;
  String? _myBreed;
  _getBreeds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken=prefs.getString('access_token');
    print('breeds' + accessToken);
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-type": "application/json",
      'Authorization': '$accessToken',
    };
    String countryInfoUrl = 'https://api.v1.agritungo.com/API/catalog/breed';
    await get(Uri.parse(countryInfoUrl), headers:header ).then((response) {
      var dataColor = json.decode(response.body);
      setState(() {
        breedList = dataColor['data']['breed'];
      });
    });
  }
  List? stallList;
  String? _myStall;
  _getStalls() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken=prefs.getString('access_token');
    print('breeds' + accessToken);
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-type": "application/json",
      'Authorization': '$accessToken',
    };
    String countryInfoUrl = 'https://api.v1.agritungo.com/API/catalog/stall';
    await get(Uri.parse(countryInfoUrl), headers:header ).then((response) {
      var dataStall = json.decode(response.body);
      setState(() {
        stallList = dataStall['data']['stalls'];
      });
    });
  }
  String? _pregnacyStatus;
   List? listPregnancy;
  _getPregnancyOption(){
    if(_myselect=="Female"){
      setState(() {
         listPregnancy=[{"option":"Yes"}, {"option":"No"}];
      });
    }
    else{
      listPregnancy=[];
    }
  }
  //pick image
  pickImageFromGallery(ImageSource source) async {
    final image = await picker.getImage(source: source);

    setState(() {
      this.image = File(image!.path);
    });
  }
}
