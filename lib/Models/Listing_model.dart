// To parse this JSON data, do
//
//     final listingModel = listingModelFromJson(jsonString);

import 'dart:convert';

ListingModel listingModelFromJson(String str) =>
    ListingModel.fromJson(json.decode(str));

String listingModelToJson(ListingModel data) => json.encode(data.toJson());

class ListingModel {
  ListingModel({
    this.status,
    this.data,
    this.message,
    this.token,
  });

  int? status;
  Data? data;
  String? message;
  String? token;

  factory ListingModel.fromJson(Map<String, dynamic> json) => ListingModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data!.toJson(),
        "message": message,
        "token": token,
      };
}

class Data {
  Data(
      {this.interestedBy,
      this.listing,
      this.unreadMessage,
      this.totalPages,
      this.unread_notification});

  List<InterestedBy>? interestedBy;
  List<Listing>? listing;
  bool? unreadMessage;
  bool? unread_notification;
  int? totalPages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        interestedBy: json["interested_by"] == null
            ? []
            : List<InterestedBy>.from(
                json["interested_by"].map((x) => InterestedBy.fromJson(x))),
        listing: json["listing"] == null
            ? []
            : List<Listing>.from(
                json["listing"].map((x) => Listing.fromJson(x))),
        unreadMessage:
            json["unread_message"] == null ? false : json["unread_message"],
        unread_notification: json["unread_notification"] == null
            ? false
            : json["unread_notification"],
        totalPages: json["total_pages"] == null ? null : json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "interested_by":
            List<dynamic>.from(interestedBy!.map((x) => x.toJson())),
        "listing": List<dynamic>.from(listing!.map((x) => x.toJson())),
        "unread_message": unreadMessage == null ? false : unreadMessage,
        "unread_notification":
            unread_notification == null ? false : unread_notification,
        "total_pages": totalPages == null ? null : totalPages,
      };
}

class InterestedBy {
  InterestedBy({
    this.id,
    this.status,
    this.time,
  });

  String? id;
  String? status;
  int? time;

  factory InterestedBy.fromJson(Map<String, dynamic> json) => InterestedBy(
        id: json["id"],
        status: json["status"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "time": time,
      };
}

class Listing {
  Listing(
      {this.memberId = "12",
      this.memberProfileId = "12",
      this.status = "status",
      this.isVerified = "isVerified",
      this.isCompleted = "isCompleted",
      this.firstName = "firstName",
      this.lastName = "lastName",
      this.gender = "gender",
      this.email = "email",
      this.profileImage = "assets/login_page.jpg",
      this.introduction = "intro",
      this.languages,
      this.country,
      this.state,
      this.city,
      this.memberAge,
      this.height,
      this.maritalStatus,
      this.onBehalf,
      this.occupation,
      this.religion,
      this.caste,
      this.subCaste,
      this.diet,
      this.drink,
      this.smoke,
      this.messageThreadId,
      this.isInterested,
      this.isFollowed,
      this.imageBlur});
  bool? imageBlur;
  String? memberId;
  String? memberProfileId;
  String? status;
  String? isVerified;
  String? isCompleted;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? profileImage;
  String? introduction;
  List<Language>? languages;
  String? country;
  String? state;
  String? city;
  int? memberAge;
  String? height;
  String? maritalStatus;
  String? onBehalf;
  String? occupation;
  String? religion;
  String? caste;
  dynamic? subCaste;
  String? diet;
  String? drink;
  String? smoke;
  dynamic? messageThreadId;
  bool? isInterested;
  bool? isFollowed;

  factory Listing.fromJson(Map<String, dynamic> json) => Listing(
        memberId: json["member_id"],
        imageBlur: json["image_blur"] == null ? false : json["image_blur"],
        memberProfileId: json["member_profile_id"],
        status: json["status"],
        isVerified: json["is_verified"],
        isCompleted: json["is_completed"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        email: json["email"],
        profileImage: json["profile_image"],
        introduction: json["introduction"],
        languages: json["languages"] == null
            ? []
            : List<Language>.from(
                json["languages"].map((x) => Language.fromJson(x))),
        country: json["country"] == null ? null : json["country"],
        state: json["state"] == null ? null : json["state"],
        city: json["city"] == null ? null : json["city"],
        memberAge: json["member_age"],
        height: json["height"],
        maritalStatus:
            json["marital_status"] == null ? null : json["marital_status"],
        onBehalf: json["on_behalf"],
        occupation: json["occupation"] == null ? null : json["occupation"],
        religion: json["religion"],
        caste: json["caste"] == null ? null : json["caste"],
        subCaste: json["sub_caste"],
        diet: json["diet"],
        drink: json["drink"],
        smoke: json["smoke"],
        messageThreadId: json["message_thread_id"],
        isInterested: json["is_interested"],
        isFollowed: json["is_followed"],
      );

  Map<String, dynamic> toJson() => {
        "member_id": memberId,
        "member_profile_id": memberProfileId,
        "status": status,
        "is_verified": isVerified,
        "is_completed": isCompleted,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "email": email,
        "profile_image": profileImage,
        "introduction": introduction,
        "languages": List<dynamic>.from(languages!.map((x) => x.toJson())),
        "country": country == null ? null : country,
        "state": state == null ? null : state,
        "city": city == null ? null : city,
        "member_age": memberAge,
        "height": height,
        "marital_status": maritalStatus == null ? null : maritalStatus,
        "on_behalf": onBehalf,
        "occupation": occupation == null ? null : occupation,
        "religion": religion,
        "caste": caste == null ? null : caste,
        "sub_caste": subCaste,
        "diet": diet,
        "drink": drink,
        "smoke": smoke,
        "message_thread_id": messageThreadId,
        "is_interested": isInterested,
        "is_followed": isFollowed,
        "image_blur": imageBlur == null ? false : imageBlur,
      };
}

class Language {
  Language({
    this.motherTongue,
    this.language,
    this.speak,
    this.read,
  });

  String? motherTongue;
  String? language;
  String? speak;
  String? read;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        motherTongue: json["mother_tongue"],
        language: json["language"],
        speak: json["speak"],
        read: json["read"],
      );

  Map<String, dynamic> toJson() => {
        "mother_tongue": motherTongue,
        "language": language,
        "speak": speak,
        "read": read,
      };
}
