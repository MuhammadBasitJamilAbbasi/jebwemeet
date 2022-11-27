class UserModel {
  String? gender;
  String? martial_status;
  String? age;
  String? address;
  String? religion;
  String? caste;
  String? star_sign;
  String? smoking;
  String? creativity;
  String? email;
  String? name;
  String? password;
  String? fcm_token;
  String? education;
  dynamic hobbies;
  String? about;
  String? height;
  String? income;
  String? sports;
  String? work;
  String? imageUrl;
  String? phone_number;
  String? uid;
  String? movies;

  UserModel({
    this.name,
    this.address,
    this.age,
    this.creativity,
    this.smoking,
    this.password,
    this.star_sign,
    this.caste,
    this.religion,
    this.martial_status,
    this.gender,
    this.email,
    this.fcm_token,
    this.height,
    this.hobbies,
    this.sports,
    this.work,
    this.about,
    this.education,
    this.income,
    this.imageUrl,
    this.phone_number,
    this.uid,
    this.movies,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    email = map['email'];
    name = map['name'];
    income = map['income'];
    education = map['education'];
    address = map['address'];
    password = map['password'];
    gender = map['gender'];
    age = map['age'];
    imageUrl = map['imageUrl'];
    martial_status = map['martial_status'];
    about = map['about'];
    work = map['work'];
    sports = map['sports'];
    hobbies = map['hobbies'];
    fcm_token = map['fcm_token'];
    height = map['height'];
    religion = map['religion'];
    caste = map['caste'];
    star_sign = map['star_sign'];
    smoking = map['smoking'];
    creativity = map['creativity'];
    phone_number = map['phone_number'];
    uid = map['uid'];
    movies = map['movies'];
  }

  Map<String, dynamic> toMap() {
    return {
      "phone_number": phone_number,
      "email": email,
      "name": name,
      "income": income,
      "education": education,
      "address": address,
      "password": password,
      "gender": gender,
      "age": age,
      "imageUrl": imageUrl,
      "martial_status": martial_status,
      "about": about,
      "work": work,
      "sports": sports,
      "hobbies": hobbies,
      "fcm_token": fcm_token,
      "height": height,
      "religion": religion,
      "caste": caste,
      "star_sign": star_sign,
      "smoking": smoking,
      "creativity": creativity,
      "uid": uid,
      "movies": movies,
    };
  }
}
