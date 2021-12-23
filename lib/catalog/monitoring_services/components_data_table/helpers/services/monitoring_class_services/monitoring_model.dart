class MonitoringModel{
  String id;
  String? userType;
 MonitoringModel({required this.id, this.userType});
 // static List<MonitoringModel> getUsers(){
 //   return <MonitoringModel>[
 //   MonitoringModel(id:1, userType:'Monitoring'),
 //   MonitoringModel(id:2, userType:'Weekly Injection'),
 //   MonitoringModel(id:2, userType:'Weekly Injection'),
 //   MonitoringModel(id:2, userType:'Weekly Injection'),
 //   ];
 //
 // }
 //

  factory MonitoringModel.fromJson(Map<String, dynamic> json) {
    return MonitoringModel(
      id: json['id'] as String,
      userType: json['name'] as String,
    );
  }
}



