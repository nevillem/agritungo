import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
TextEditingController _dateC = TextEditingController();

vaccineDialog(BuildContext context, String title, String monitoring) {
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
                            "Add Branch",
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
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 5, right: 10,),
                      child:TextFormField(
                        validator: (value) {
                          if (value ==null) {
                            return "required";
                          } else
                            return null;
                        },
                        controller: _dateC, //editing controller of this TextField
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
                            child: Text('Save',
                              style: TextStyle(color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                            onPressed: () {

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