import 'package:jabwemeet/Models/Hobbies_Model.dart';

class UserModel {
  String? gender;
  bool? subscribe;
  bool? blur;
  String? martial_status;
  int? age;
  String? birthday;
  String? address;
  String? religion;
  String? caste;
  String? job_title;
  String? industry;
  String? childerns;
  String? email;
  String? name;
  String? password;
  String? fcm_token;
  String? education;
  List<InterestModel>? hobbies;
  String? about;
  String? height;
  String? income;
  List<dynamic>? languages;
  String? work;
  String? imageUrl;
  String? phone_number;
  String? uid;
  String? longitude;
  String? latitude;
  String? religious_practice;
  List<dynamic>? imagesList;

  UserModel({
    this.name,
    this.address,
    this.subscribe,
    this.blur,
    this.age,
    this.birthday,
    this.imagesList,
    this.childerns,
    this.industry,
    this.password,
    this.job_title,
    this.caste,
    this.religion,
    this.martial_status,
    this.gender,
    this.email,
    this.fcm_token,
    this.height,
    this.hobbies,
    this.languages,
    this.work,
    this.about,
    this.education,
    this.income,
    this.imageUrl,
    this.longitude,
    this.latitude,
    this.phone_number,
    this.uid,
    this.religious_practice,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    email = map['email'];
    name = map['name'];
    imagesList = map['imagesList'];
    income = map['income'];
    education = map['education'];
    subscribe = map['subscribe'];
    blur = map['blur'];
    education = map['education'];
    address = map['address'];
    password = map['password'];
    gender = map['gender'];
    latitude = map['latitude'];
    longitude = map['longitude'];
    age = map['age'];
    birthday = map['birthday'];
    imageUrl = map['imageUrl'];
    martial_status = map['martial_status'];
    about = map['about'];
    work = map['work'];
    languages = map['languages'];
    fcm_token = map['fcm_token'];
    height = map['height'];
    religion = map['religion'];
    caste = map['caste'];
    job_title = map['job_title'];
    industry = map['industry'];
    childerns = map['childerns'];
    phone_number = map['phone_number'];
    uid = map['uid'];
    religious_practice = map['religious_practice'];
    if (map['hobbies'] != null) {
      hobbies = <InterestModel>[];

      map['hobbies'].forEach(
              (items) => hobbies!.add(new InterestModel.fromMap(items)));
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "phone_number": phone_number,
      "email": email,
      "name": name,
      "longitude": longitude,
      "latitude": latitude,
      "name": name,
      "blur": blur,
      "name": name,
      "income": income,
      "imagesList": imagesList,
      "education": education,
      "address": address,
      "password": password,
      "birthday": birthday,
      "gender": gender,
      "age": age,
      "imageUrl": imageUrl,
      "martial_status": martial_status,
      "about": about,
      "work": work,
      "languages": languages,
      "hobbies": hobbies,
      "fcm_token": fcm_token,
      "height": height,
      "religion": religion,
      "caste": caste,
      "job_title": job_title,
      "industry": industry,
      "childerns": childerns,
      "uid": uid,
      "religious_practice": religious_practice,
    };
  }
}
