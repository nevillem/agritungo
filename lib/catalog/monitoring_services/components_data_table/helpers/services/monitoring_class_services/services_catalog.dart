import 'dart:convert';
import 'package:agritungo/catalog/monitoring_services/components_data_table/helpers/services/monitoring_class_services/monitoring_model.dart';
import 'package:http/http.dart' as http;
class Services{
  static const String url="https://api.v1.agritungo.com/API/districts/2";
  static Future<List<MonitoringModel>> getMonitorings() async {
      final response = await http.get(Uri.parse(url));
      if (201 == response.statusCode) {
        Map<String, dynamic> datas= jsonDecode(response.body);
        List finalData= datas['data']['districts'];
        List<MonitoringModel> list = finalData.map((tagJson) => MonitoringModel.fromJson(tagJson)).toList();
       // print(list);
        return list;
      } else {
        throw Exception() ;
      }
  }

}