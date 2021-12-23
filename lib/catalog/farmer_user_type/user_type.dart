
import 'package:agritungo/catalog/farmer_user_type/usertype_form.dart';
import 'package:agritungo/theme.dart';
import 'package:flutter/material.dart';

class UserType extends StatefulWidget {
  const UserType({Key? key}) : super(key: key);

  @override
  _UserTypeState createState() => _UserTypeState();
}

class _UserTypeState extends State<UserType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text('User Type'),
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
          userTypeDialog(context, "", "");
        },
        child: Icon(Icons.add),
      ),
    );
  }

  SingleChildScrollView _bodyDataTable(){

    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
      columnSpacing: 40,
      columns: [

        DataColumn(
            label: Text('#',
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: Color(0xFF737373)
                )
            ),
            numeric: false,
            tooltip: "id"
        ),
        DataColumn(label: Text('User Type Name',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15,
                color: Color(0xFF737373)
            )),
            numeric: false,
            tooltip: "This is user type"),
        DataColumn(label: Text('')),
        DataColumn(label: Text('Action',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: Color(0xFF737373)
          ),),
            numeric: false,
            tooltip: "do action"),
      ], rows: [],
    );
  }
}
