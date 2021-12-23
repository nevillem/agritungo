import 'package:agritungo/myfarm/branches/farm_branches_form.dart';
import 'package:agritungo/theme.dart';
import 'package:flutter/material.dart';
class BranchesMain extends StatefulWidget {
  const BranchesMain({Key? key}) : super(key: key);

  @override
  _BranchesMainState createState() => _BranchesMainState();
}

class _BranchesMainState extends State<BranchesMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text('Farm Branches'),
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
          vaccineDialog(context,'','');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _bodyDataTable() {}
}
