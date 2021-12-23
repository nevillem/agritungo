import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

showCustomDialog(BuildContext context, String title, String monitoring) {
  return showDialog(
      context: context,
      barrierDismissible: false,
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
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin:EdgeInsets.only(left: 15),
                      child: Text(
                        "Add Monitoring Services",
                        style: TextStyle(fontSize: 14.0,
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
                      hintText: 'Monitoring service name',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
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
                SizedBox(height: 10,),
              ],
            ),
          ),

        );
      });
}