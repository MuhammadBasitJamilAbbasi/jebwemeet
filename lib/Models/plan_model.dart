// To parse this JSON data, do
//
//     final planModel = planModelFromJson(jsonString);

import 'dart:convert';

PlanModel planModelFromJson(String str) => PlanModel.fromJson(json.decode(str));

String planModelToJson(PlanModel data) => json.encode(data.toJson());

class PlanModel {
  PlanModel({
    this.id,
    this.name,
    this.price,
    this.days,
    this.description,
    this.status,
    this.dateCreated,
  });

  String? id;
  String? name;
  String? price;
  String? days;
  String? description;
  String? status;
  DateTime? dateCreated;

  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        days: json["days"],
        description: json["description"],
        status: json["status"],
        dateCreated: DateTime.parse(json["date_created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "days": days,
        "description": description,
        "status": status,
        "date_created": dateCreated!.toIso8601String(),
      };
}
