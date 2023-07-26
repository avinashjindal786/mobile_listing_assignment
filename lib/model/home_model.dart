// To parse this JSON data, do
//
//     final homeListingModel = homeListingModelFromMap(jsonString);

import 'dart:convert';


class HomeListingModel {
  List<Listing>? listings;
  String? nextPage;
  String? message;

  HomeListingModel({
    this.listings,
    this.nextPage,
    this.message,
  });

  factory HomeListingModel.fromJson(Map<String, dynamic> json) => HomeListingModel(
        listings:json["listings"] == null ? null :List<Listing>.from(json["listings"].map((x) => Listing.fromMap(x))),
        nextPage: json["nextPage"],
        message: json["message"],
      );


}

class Listing {
  String? id;
  String? deviceCondition;
  String? listedBy;
  String? deviceStorage;
  List<ImageModel>? images;
  ImageModel? defaultImage;
  String? listingLocation;
  String? make;
  String? marketingName;
  String? mobileNumber;
  String? model;
  bool? verified;
  String? status;
  String? listingDate;
  String? deviceRam;
  String? createdAt;
  String? listingId;
  int? listingNumPrice;
  String? listingState;

  Listing({
    this.id,
    this.deviceCondition,
    this.listedBy,
    this.deviceStorage,
    this.images,
    this.defaultImage,
    this.listingLocation,
    this.make,
    this.marketingName,
    this.mobileNumber,
    this.model,
    this.verified,
    this.status,
    this.listingDate,
    this.deviceRam,
    this.createdAt,
    this.listingId,
    this.listingNumPrice,
    this.listingState,
  });

  factory Listing.fromMap(Map<String, dynamic> json) => Listing(
        id: json["_id"],
        deviceCondition: json["deviceCondition"],
        listedBy: json["listedBy"],
        deviceStorage: json["deviceStorage"],
        images: List<ImageModel>.from(json["images"].map((x) => ImageModel.fromMap(x))),
        defaultImage: ImageModel.fromMap(json["defaultImage"]),
        listingLocation: json["listingLocation"],
        make: json["make"],
        marketingName: json["marketingName"],
        mobileNumber: json["mobileNumber"],
        model: json["model"],
        verified: json["verified"],
        status: json["status"],
        listingDate: json["listingDate"],
        deviceRam: json["deviceRam"],
        createdAt: json["createdAt"],
        listingId: json["listingId"],
        listingNumPrice: json["listingNumPrice"],
        listingState: json["listingState"],
      );

  // Map<String, dynamic> toMap() => {
  //       "_id": id,
  //       "deviceCondition": deviceConditionValues.reverse[deviceCondition],
  //       "listedBy": listedBy,
  //       "deviceStorage": deviceStorage,
  //       "images": List<dynamic>.from(images.map((x) => x.toMap())),
  //       "defaultImage": defaultImage.toMap(),
  //       "listingLocation": listingLocation,
  //       "make": makeValues.reverse[make],
  //       "marketingName": marketingNameValues.reverse[marketingName],
  //       "mobileNumber": mobileNumber,
  //       "model": model,
  //       "verified": verified,
  //       "status": statusValues.reverse[status],
  //       "listingDate": listingDate,
  //       "deviceRam": deviceRam,
  //       "createdAt": createdAt,
  //       "listingId": listingId,
  //       "listingNumPrice": listingNumPrice,
  //       "listingState": listingState,
  //     };
}

class ImageModel {
  String? fullImage;

  ImageModel({
    this.fullImage,
  });

  factory ImageModel.fromMap(Map<String, dynamic> json) => ImageModel(
        fullImage: json["fullImage"],
      );

  Map<String, dynamic> toMap() => {
        "fullImage": fullImage,
      };
}


