// To parse this JSON data, do
//
//     final filterModel = filterModelFromMap(jsonString);

import 'dart:convert';

class FilterModel {
  Filters? filters;
  String? message;

  FilterModel({
    this.filters,
    this.message,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        filters: Filters.fromMap(json["filters"]),
        message: json["message"],
      );

  // Map<String, dynamic> toMap() => {
  //       "filters": filters.toMap(),
  //       "message": message,
  //     };
}

class Filters {
  List<String>? make;
  List<String>? condition;
  List<String>? storage;
  List<String>? ram;

  Filters({
    this.make,
    this.condition,
    this.storage,
    this.ram,
  });

  factory Filters.fromMap(Map<String, dynamic> json) => Filters(
        make: List<String>.from(json["make"].map((x) => x)),
        condition: List<String>.from(json["condition"].map((x) => x)),
        storage: List<String>.from(json["storage"].map((x) => x)),
        ram: List<String>.from(json["ram"].map((x) => x)),
      );

  // Map<String, dynamic> toMap() => {
  //       "make": List<dynamic>.from(make.map((x) => x)),
  //       "condition": List<dynamic>.from(condition.map((x) => x)),
  //       "storage": List<dynamic>.from(storage.map((x) => x)),
  //       "ram": List<dynamic>.from(ram.map((x) => x)),
  //     };
}
