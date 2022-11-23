import 'dart:convert';

ExploreModel ExploreModelFromJson(String str) =>
    ExploreModel.fromJson(json.decode(str));

String ExploreModelToJson(ExploreModel data) => json.encode(data.toJson());

class ExploreModel {
  ExploreModel({
    this.status,
    this.data,
    this.message,
    this.token,
  });

  int? status;
  List<Datum>? data;
  String? message;
  String? token;

  factory ExploreModel.fromJson(Map<String, dynamic> json) => ExploreModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
        "token": token,
      };
}

class Datum {
  Datum(
      {this.memberId,
      this.memberProfileId,
      this.status,
      this.isVerified,
      this.isCompleted,
      this.firstName,
      this.lastName,
      this.gender,
      this.email,
      this.profileImage,
      this.introduction,
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
      this.isLiked = false,
      this.isFollow = false,
      this.imageBlur = false,
      this.message_thread_id = "0"});

  bool? isLiked;
  bool? isFollow;
  bool? imageBlur;
  dynamic? message_thread_id;
  dynamic? memberId;
  dynamic? memberProfileId;
  dynamic? status;
  dynamic? isVerified;
  dynamic? isCompleted;
  dynamic? firstName;
  dynamic? lastName;
  dynamic? gender;
  dynamic? email;
  dynamic? profileImage;
  dynamic? introduction;
  List<Language>? languages;
  dynamic? country;
  dynamic? state;
  dynamic? city;
  dynamic? memberAge;
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
      memberId: json["member_id"],
      memberProfileId: json["member_profile_id"],
      status: "status",
      isVerified: json["is_verified"],
      isCompleted: json["is_completed"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      gender: json["gender"] ?? "gender",
      email: json["email"],
      profileImage: json["profile_image"],
      introduction: json["introduction"],
      languages: List<Language>.from(
          json["languages"].map((x) => Language.fromJson(x))),
      country: json["country"] == null ? null : json["country"],
      state: json["state"] == null ? null : json["state"],
      city: json["city"] == null ? null : json["city"],
      memberAge: json["member_age"],
      height: json["height"],
      imageBlur: json["image_blur"] == null ? false : json["image_blur"],
      maritalStatus:
          json["marital_status"] == null ? null : json["marital_status"],
      onBehalf: "on_behalf",
      occupation: json["occupation"] == null ? null : json["occupation"],
      religion: "religion",
      caste: json["caste"] == null ? null : json["caste"],
      subCaste: json["sub_caste"],
      diet: json["diet"],
      drink: json["drink"],
      smoke: json["smoke"],
      isLiked: json["is_interested"] == null ? false : json["is_interested"],
      isFollow: json["is_followed"] == null ? false : json["is_followed"],
      message_thread_id: json["message_thread_id"] == null
          ? "0"
          : json["message_thread_id"].toString());

  Map<String, dynamic> toJson() => {
        "is_interested": isLiked,
        "is_followed": isFollow,
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
        "image_blur": imageBlur == null ? false : imageBlur,
      };
}
//
// enum Gender { FEMALE }
//
// final genderValues = EnumValues({
//   "Female": Gender.FEMALE
// });

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
        motherTongue:
            json["mother_tongue"] == null ? null : json["mother_tongue"],
        language: json["language"] == null ? null : json["language"],
        speak: json["speak"] == null ? null : json["speak"],
        read: json["read"] == null ? null : json["read"],
      );

  Map<String, dynamic> toJson() => {
        "mother_tongue": motherTongue == null ? null : motherTongue,
        "language": language == null ? null : language,
        "speak": speak == null ? null : speak,
        "read": read == null ? null : read,
      };
}
//
// enum MaritalStatus { NEVER_MARRIED, WIDOWED }
//
// final maritalStatusValues = EnumValues({
//   "Never Married": MaritalStatus.NEVER_MARRIED,
//   "Widowed": MaritalStatus.WIDOWED
// });
//
// enum OnBehalf { SELF, WALI }
//
// final onBehalfValues = EnumValues({
//   "Self": OnBehalf.SELF,
//   "Wali": OnBehalf.WALI
// });
//
// enum Religion { ISLAM }
//
// final religionValues = EnumValues({
//   "Islam": Religion.ISLAM
// });
//
// enum Status { APPROVED }
//
// final statusValues = EnumValues({
//   "approved": Status.APPROVED
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String>? reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap!;
//   }
// }
//

// // To parse this JSON data, do
// //
// //     final ExploreModel = ExploreModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ExploreModel ExploreModelFromJson(String str) =>
//     ExploreModel.fromJson(json.decode(str));
//
// String ExploreModelToJson(ExploreModel data) => json.encode(data.toJson());
//
// class ExploreModel {
//   ExploreModel({
//     this.status,
//     this.data,
//     this.message,
//     this.token,
//   });
//
//   int? status;
//   List<Map<String, String>>? data;
//   String? message;
//   String? token;
//
//   factory ExploreModel.fromJson(Map<String, dynamic> json) => ExploreModel(
//         status: json["status"],
//         data: List<Map<String, String>>.from(json["data"].map((x) => Map.from(x)
//             .map((k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
//         message: json["message"],
//         token: json["token"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": List<dynamic>.from(data!.map((x) => Map.from(x).map((k, v) =>
//             MapEntry<String, dynamic>(
//                 k, v.toString() == "null" ? "null" : v)))),
//         "message": message,
//         "token": token,
//       };
// }
