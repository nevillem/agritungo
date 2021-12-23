import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

TextEditingController colorName = TextEditingController();
TextEditingController _dateC = TextEditingController();
GlobalKey<FormState> _addAnimal = GlobalKey<FormState>();
String? _myselect;
List<Map> _selectGender = [{"gender":"Male"}, {"gender":"Female"}];

ManageAnimalDialog1(BuildContext context, String accessTokens, refreshTokens, sessionid) {
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
                                  hintText: 'Date of Birth',//icon of text field
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
                              margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
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
                                hint: new Text("Choose Gender"),
                                value: _myselect,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _myselect = newValue;
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

                          ],
                        ),


                        Container(
                          margin: EdgeInsets.only(left: 15.0, top: 10, right: 10.0),
                          child: TextFormField(
                            decoration:InputDecoration(
                              // errorText: 'required',
                              hintText: 'Branch Manager',
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
                          child: TextFormField(
                            decoration:InputDecoration(
                              // errorText: 'required',
                              hintText: 'Address',
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
                          margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
                          child:TextFormField(
                            validator: (value) {
                              if (value ==null) {
                                return "required";
                              } else
                                return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.calendar_today),
                              hintText: 'Setup Date',//icon of text field
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
      }).then((value) {
    if (value == null) return;
    if (value) {
      Navigator.of(context).pop();
      nextDialog2(context, accessTokens,refreshTokens,sessionid);
    } else {
      // user pressed No button
    }
  });
}

nextDialog2(BuildContext context, String accessTokens, refreshTokens, sessionid) {
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

                        Container(
                          margin: EdgeInsets.only(left: 15.0, top: 10, right: 10.0),
                          child: TextFormField(
                            decoration:InputDecoration(
                              // errorText: 'required',
                              hintText: 'Branch name',
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
                              hintText: 'Phone Number',
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
                              hintText: 'Branch Manager',
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
                          child: TextFormField(
                            decoration:InputDecoration(
                              // errorText: 'required',
                              hintText: 'Address',
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

