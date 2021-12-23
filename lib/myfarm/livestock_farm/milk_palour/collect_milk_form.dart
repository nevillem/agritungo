
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

TextEditingController colorName = TextEditingController();
TextEditingController _dateC = TextEditingController();
GlobalKey<FormState> _addColor = GlobalKey<FormState>();
// collectMilkDialog(BuildContext context, String accessTokens, refreshTokens, sessionid) {
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//             builder: (context, setState) {
//             return AlertDialog(
//               insetPadding: EdgeInsets.symmetric(horizontal: 10),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(5.0))),
//               contentPadding: EdgeInsets.only(top: 10.0),
//               content: Container(
//                 width:MediaQuery
//                     .of(context)
//                     .size.width * 10,
//                 child: Form(
//                   key: _addColor,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           Container(
//                             margin:EdgeInsets.only(left: 15),
//                             child: Text(
//                               "Collect Milk List",
//                               style: TextStyle(fontSize: 14.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF737373)),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5.0,
//                       ),
//                       Divider(
//                         color: Color(0xFFF1F1F1),
//                         height: 2.0,
//                       ),
//
//                       Row(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(left: 10, top: 5),
//                             width:150,
//                             child:TextFormField(
//                               validator: (value) {
//                                 if (value ==null) {
//                                   return "required";
//                                 } else
//                                   return null;
//                               },
//                               controller: _dateC,
//                               decoration: InputDecoration(
//                                 prefixIcon: Icon(Icons.calendar_today),
//                                 hintText: 'Date',//icon of text field
//                                 hintStyle: TextStyle(fontSize: 12),
//                                 // errorText: 'required',
//                                 isDense: true,
//                                 contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(3),
//                                   borderSide: BorderSide(color: Colors.black12, width: 0),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(3),
//                                   borderSide: BorderSide(color: Colors.black12),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(3),
//                                   borderSide: BorderSide(color: Colors.black12,),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(3),
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                                 errorStyle: TextStyle(fontSize:10),
//                                 filled: true,
//                                 fillColor: Colors.white,
//
//                               ),            readOnly: true,  //set it true, so that user will not able to edit text
//                               onTap: () async {
//                                 DateTime? pickedDate = await showDatePicker(
//                                     context: context, initialDate: DateTime(2010),
//                                     firstDate: DateTime(1945), //DateTime.now() - not to allow to choose before today.
//                                     lastDate: DateTime(2010)
//                                 );
//
//                                 if(pickedDate != null ){
//                                   print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
//                                   String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                                   print(formattedDate); //formatted date output using intl package =>  2021-03-16
//                                   //you can implement different kind of Date Format here according to your requirement
//                                   setState(() {
//                                     _dateC.text = formattedDate; //set output date to TextField value.
//                                   });
//                                 }else{
//                                   print("Date is not selected");
//                                 }
//                               },
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(left: 10, top: 5),
//                             width: 150,
//                             child: TextFormField(
//                               decoration:InputDecoration(
//                                 // errorText: 'required',
//                                 hintText: 'Animal Tag No',
//                                 hintStyle: TextStyle(color: Colors.black26, fontSize: 13),
//                                 isDense: true,
//                                 contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.black12, width: 0),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.black12),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.black12,),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                                 errorStyle: TextStyle(fontSize:10),
//                                 filled: true,
//                                 // fillColor: Colors.black12,
//                               ),
//                             ),
//
//                           ),
//                         ],
//                       ),
//                         Row(
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(left: 10, top: 5),
//                             width:150,
//                             child:TextFormField(
//                               validator: (value) {
//                                 if (value ==null) {
//                                   return "required";
//                                 } else
//                                   return null;
//                               },
//                               controller: _dateC,
//                               decoration: InputDecoration(
//                                 prefixIcon: Icon(Icons.calendar_today),
//                                 hintText: 'Date',//icon of text field
//                                 hintStyle: TextStyle(fontSize: 12),
//                                 // errorText: 'required',
//                                 isDense: true,
//                                 contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(3),
//                                   borderSide: BorderSide(color: Colors.black12, width: 0),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(3),
//                                   borderSide: BorderSide(color: Colors.black12),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(3),
//                                   borderSide: BorderSide(color: Colors.black12,),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(3),
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                                 errorStyle: TextStyle(fontSize:10),
//                                 filled: true,
//                                 fillColor: Colors.white,
//
//                               ),            readOnly: true,  //set it true, so that user will not able to edit text
//                               onTap: () async {
//                                 DateTime? pickedDate = await showDatePicker(
//                                     context: context, initialDate: DateTime(2010),
//                                     firstDate: DateTime(1945), //DateTime.now() - not to allow to choose before today.
//                                     lastDate: DateTime(2010)
//                                 );
//
//                                 if(pickedDate != null ){
//                                   print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
//                                   String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//                                   print(formattedDate); //formatted date output using intl package =>  2021-03-16
//                                   //you can implement different kind of Date Format here according to your requirement
//                                   setState(() {
//                                     _dateC.text = formattedDate; //set output date to TextField value.
//                                   });
//                                 }else{
//                                   print("Date is not selected");
//                                 }
//                               },
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(left: 10, top: 5),
//                             width: 150,
//                             child: TextFormField(
//                               decoration:InputDecoration(
//                                 // errorText: 'required',
//                                 hintText: 'Collected From',
//                                 hintStyle: TextStyle(color: Colors.black26, fontSize: 13),
//                                 isDense: true,
//                                 contentPadding: EdgeInsets.fromLTRB(15, 10, 10, 15),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.black12, width: 0),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.black12),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.black12,),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                                 errorStyle: TextStyle(fontSize:10),
//                                 filled: true,
//                                // fillColor: Colors.black12,
//                               ),
//                             ),
//
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(top: 10),
//                             alignment: Alignment.centerLeft,
//                             child: FlatButton(
//                               color: Color(0xFF737373),
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.all(Radius.circular(10))),
//                               child: Text('Cancel',
//                                 style: TextStyle(color: Color(0xFFFFFFFF),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                           ),
//                           Container(
//                             // alignment: Alignment.centerRight,
//                             margin: EdgeInsets.only(left: 70),
//                             child: FlatButton(
//                               color: Color(0xFF73B41A),
//                               shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.all(Radius.circular(10))),
//                               child: Text('Save',
//                                 style: TextStyle(color: Color(0xFFFFFFFF),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),),
//                               onPressed: () {
//                                 if (_addColor.currentState!.validate()) {
//                                   _saveData(context, colorName.text, accessTokens, refreshTokens, sessionid);
//                                   Navigator.of(context).pop(true);
//                                 }
//                                 else{
//
//                                 }
//                               },
//                             ),
//                           ),
//
//                         ],
//                       ),
//                       SizedBox(height: 10,),
//                     ],
//                   ),
//                 ),
//               ),
//
//             );
//           }
//         );
//       });
// }
// _saveData(context, colorName, String accessTokens, refreshTokens, sessionid) async {
//   Map postdata = {
//     "colorname": "$colorName"
//   };
//   var _json= utf8.encode(jsonEncode(postdata));
//   String url = 'https://api.v1.agritungo.com/API/catalog/color';
//   Map<String, String> headers = {
//     "Accept": "application/json",
//     'Content-Type': 'application/json',
//     'Authorization': '$accessTokens',
//   };
//   print('here: $accessTokens');
//   print('refresh: $refreshTokens');
//   print('id: $sessionid');
//
//   if(colorName==''){
//     Fluttertoast.showToast(
//         msg: 'Please enter color name',
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 5,
//         backgroundColor: Colors.red,
//         textColor: Colors.white
//     );
//   }
//   else{
//     Response response = await post(Uri.parse(url), headers: headers, body: _json);
//     if(response.statusCode==401){
//       Map _refreshLogin = {
//         'refresh_token': refreshTokens,
//       };
//       var _json2 = utf8.encode(jsonEncode(_refreshLogin));
//       String urlRefresh = ('https://api.v1.agritungo.com/API/sessions/$sessionid');
//       Response responseRefresh = await patch(
//           Uri.parse(urlRefresh), headers: headers, body: _json2);
//       Map data = jsonDecode(responseRefresh.body);
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       if (responseRefresh.statusCode == 200) {
//         print(data);
//         print('new refresh' + data['data']['refresh_token']);
//         prefs.setString('access_token', data['data']['access_token']);
//         prefs.setString('refresh_token', data['data']['refresh_token']);
//         prefs.reload();
//         print('new accessToken' + data['data']['access_token']);
//         var newAccess=data['data']['access_token'];
//         Map<String, String> headerResponse = {
//           "Accept": "application/json",
//           'Content-Type': 'application/json',
//           'Authorization': '$newAccess',
//         };
//         Response response2 = await post(Uri.parse(url), headers: headerResponse, body: _json);
//         if(response2.statusCode==201){
//           print(response2.body);
//           Fluttertoast.showToast(
//               msg: 'Successful',
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.BOTTOM,
//               timeInSecForIosWeb: 2,
//               backgroundColor: Colors.green,
//               textColor: Colors.white
//           );
//           _clearValues();
//         }
//         else{
//           print(response2.statusCode);
//           print(response2.body);
//           Fluttertoast.showToast(
//               msg: 'Please Try again',
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.BOTTOM,
//               timeInSecForIosWeb: 2,
//               backgroundColor: Colors.red,
//               textColor: Colors.white
//           );
//         }
//       }
//       else if (responseRefresh.statusCode == 401) {
//         Fluttertoast.showToast(
//             msg: 'Failed Please try again, Later',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 2,
//             backgroundColor: Colors.red,
//             textColor: Colors.white
//         );
//
//       }
//     }
//     else if(response.statusCode==201){
//       print(response.body);
//       Fluttertoast.showToast(
//           msg: 'Successful',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 2,
//           backgroundColor: Colors.green,
//           textColor: Colors.white
//       );
//       _clearValues();
//     }
//     else{
//       print(response.statusCode);
//       print(response.body);
//       Fluttertoast.showToast(
//           msg: 'Please Try again',
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           timeInSecForIosWeb: 2,
//           backgroundColor: Colors.red,
//           textColor: Colors.white
//       );
//     }
//   }
// }
// _clearValues() {
//   colorName.text = '';
// }
// List? parishList;
// String? _myParish;
// getTagNo(token) async {
//   print(token);
//   String countryInfoUrl = 'https://api.v1.agritungo.com/API/parishes/$_mysubCounties';
//   await get(Uri.parse(countryInfoUrl)).then((response) {
//     var data = json.decode(response.body);
//     //  print(data);
//     setState(() {
//       parishList = data['data']['parish'];
//     });
//   });
// }