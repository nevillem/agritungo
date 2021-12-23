
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalenderPicker extends StatefulWidget {
  const CalenderPicker({Key? key}) : super(key: key);

  @override
  _CalenderPickerState createState() => _CalenderPickerState();
}

class _CalenderPickerState extends State<CalenderPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children:<Widget> [
            TextFormField(

              readOnly: true,
              onTap: () {
            setState(() {
              selectDate(context);
            });
            },
             decoration: InputDecoration(
                 hintText: ('${myFormat.format(_date)}'),
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
          ],
        ),
      ),
    );
  }


  var myFormat = DateFormat('dd-MM-yyyy');
  DateTime _date= DateTime(2012);
  Future<Null> selectDate(BuildContext context) async{
    DateTime? dateTime= await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1947),
        lastDate: DateTime(2012),
        //builder: BuildContext(context, Widget child),
    );
  if((dateTime !=null) && (dateTime !=_date) ){
    setState(() {
      _date=dateTime;
      print(_date.toString());
    });
  }
  }
}
