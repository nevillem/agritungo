
import 'dart:convert';

List<IncomeModel> incomeModelFromJson(String str) => List<IncomeModel>.from(
    json.decode(str).map((x) => IncomeModel.fromJson(x)));

String incomeModelToJson(List<IncomeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IncomeModel{
  String month;
  int count;
  IncomeModel({required this.month, required this.count});
  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
   month: json['name'],
   count: json['count']
  );
  Map<String, dynamic> toJson() =>
      {
     "name": month,
     "count": count,

      };
}