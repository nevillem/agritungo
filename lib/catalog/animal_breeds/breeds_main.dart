
import 'dart:convert';
import 'package:agritungo/catalog/animal_breeds/breads_form.dart';
import 'package:agritungo/catalog/animal_breeds/breed_model/models_b.dart';
import 'package:agritungo/signup/register.dart';
import 'package:agritungo/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class BreedsMain extends StatefulWidget {
  const BreedsMain({Key? key}) : super(key: key);

  @override
  _BreedsMainState createState() => _BreedsMainState();
}

class _BreedsMainState extends State<BreedsMain> {
  var accessToken;
  var refreshToken;
  var sessionid;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPrefs();
    _getBreeds();
  }
  List <BreedModel> breedModel = [];
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text('Animal Breeds'),
          titleTextStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 20,),
          elevation: 5,
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
          )
      ),
      body: RefreshIndicator(
        onRefresh: _getBreeds,
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
          breedsDialog(context,  accessToken, refreshToken,sessionid);
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
                      _getBreeds();
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
                        _getBreeds();
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

  Future<void> _getBreeds() async {
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
    var url = Uri.parse('https://api.v1.agritungo.com/API/catalog/breed');
    var response = await http.get((url), headers: header);
    Map<String, dynamic> datas = jsonDecode(response.body);
    List finalData = datas['data']['breed'];
    List<BreedModel> tempdata = finalData.map((tagJson) => BreedModel.fromJson(tagJson)).toList();
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
          _getBreeds();
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
      _getBreeds();
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
            _getBreeds();
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
        _getBreeds();
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
}
