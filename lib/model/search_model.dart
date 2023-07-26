// To parse this JSON data, do
//
//     final filterModel = filterModelFromMap(jsonString);

import 'dart:convert';



class SearchModel {
  List<String>? makes;
  List<String>? models;
  String? message;

  SearchModel({
    this.makes,
    this.models,
    this.message,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        makes: json["makes"] == null ? null : List<String>.from(json["makes"].map((x) => x)),
        models: json["models"] == null ? null : List<String>.from(json["models"].map((x) => x)),
        message: json["message"],
      );

  // Map<String, dynamic> toMap() => {
  //       "makes": List<dynamic>.from(makes.map((x) => x)),
  //       "models": List<dynamic>.from(models.map((x) => x)),
  //       "message": message,
  //     };
}
