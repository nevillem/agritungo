
import 'package:agritungo/catalog/vaccination/vaccine_form.dart';
import 'package:agritungo/theme.dart';
import 'package:flutter/material.dart';

class VaccinationMain extends StatefulWidget {
  const VaccinationMain({Key? key}) : super(key: key);

  @override
  _VaccinationMainState createState() => _VaccinationMainState();
}

class _VaccinationMainState extends State<VaccinationMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text('Vaccine List'),
          titleTextStyle: TextStyle(fontWeight: FontWeight.w800, fontSize: 20,),
          elevation: 5,
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
          )
      ),
      body: Container(
        // margin: EdgeInsets.only(left:20, right: 20,),
        child: _bodyDataTable(),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF73B41A),
        onPressed: () {
          vaccineDialog(context, "", "");
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _bodyDataTable() {}
}
