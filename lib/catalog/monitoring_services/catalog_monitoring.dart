import 'package:agritungo/catalog/monitoring_services/components_data_table/helpers/services/monitoring_class_services/monitoring_model.dart';
import 'package:agritungo/catalog/monitoring_services/components_data_table/helpers/services/monitoring_class_services/services_catalog.dart';
import 'package:agritungo/catalog/monitoring_services/monitoring_service_form.dart';
import 'package:agritungo/theme.dart';
import 'package:flutter/material.dart';

class CatalogMonitoring extends StatefulWidget {
  const CatalogMonitoring({Key? key}) : super(key: key);

  @override
  _CatalogMonitoringState createState() => _CatalogMonitoringState();
}

class _CatalogMonitoringState extends State<CatalogMonitoring> {
  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);
 List <MonitoringModel> monitoring=[];
  DataTable dataBody() {
    return DataTable(
      sortAscending: true,
        sortColumnIndex: 0,
        columnSpacing: 43,
        columns: [

          DataColumn(
              label: Text('#'
              ),
              numeric: false,
              tooltip: "id"
          ),
          DataColumn(label: Text('User Type',
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
        ],
        rows:monitoring.map((e) => DataRow(
            selected: monitoring.indexOf(e) % 2 == 0 ? true : false,

            cells: [
              DataCell(Text(
                e.id.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Color(0xFF737373)
                  )
              )),
              DataCell(Text(
                e.userType.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Color(0xFF737373)
                  )
              )),
              DataCell(Text('Edit',
                style: TextStyle(color: Color(0xFF73B41A),
                    fontWeight: FontWeight.normal,
                    fontSize: 15,),
              ),
                onTap: (){
                print(e.id);
                },
             ),
              DataCell(
                Text('Delete',
                style: TextStyle(color: Color(0xFFF00000),
                  fontWeight: FontWeight.normal,
                  fontSize: 15,),
              ),
             ),
            ],

        )
        ).toList(),
    );
  }
  @override
  void initState() {
    //monitoring= MonitoringModel.getUsers();
    monitoring=[];
    // TODO: implement initState
    _getMonitorings();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text('Monitoring'),
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
          showCustomDialog(context, "", "");
          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder:
          //     (BuildContext context) => Monitoringform()), (Route<dynamic> route) => false);
          //
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

   _getMonitorings() {
  Services.getMonitorings().then((value) {
    if(this.mounted){
      setState(() {
      monitoring = value;
      print(value.length);
    });
  }
  });
  }

}
